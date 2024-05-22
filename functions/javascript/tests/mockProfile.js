
const path = require("path");
const fs = require("fs");
const admin = require("firebase-admin");

const { Collections } = require("../src/constants");


const generatedProfilePath = "../../scripts/generated";
const singleProfilePath = path.join(generatedProfilePath, "single_profile.json");
const multipleProfilePath = path.join(generatedProfilePath, "multiple_profile.json");

function convertProfileFirebase(profile, matchedUserIds = null, firstName = null) {
  const dateOfBirth = new Date(profile.dateOfBirth);
  const asFirebaseDate = admin.firestore.Timestamp.fromDate(dateOfBirth);
  profile.dateOfBirth = asFirebaseDate;
  if (Array.isArray(matchedUserIds)) {
    profile.matchedUserIds = matchedUserIds;
    profile.numMatches = matchedUserIds.length;
  }
  if (firstName !== null) {
    profile.firstName = firstName;
  }
  return profile;
}


function storeMyProfile(userId, matchedUserIds = null, firstName = null) {
  const profileData = JSON.parse(fs.readFileSync(singleProfilePath, "utf8"));
  return admin.firestore().collection(Collections.PROFILES)
      .doc(userId).set(convertProfileFirebase(profileData, matchedUserIds, firstName));
}

function storeOtherProfile(matchedUserIds = []) {
  const profileData = JSON.parse(fs.readFileSync(singleProfilePath, "utf8"));
  const gender = profileData.gender;
  profileData.gender = profileData.genderPreferences[0];
  profileData.genderPreferences = [gender];
  return admin.firestore().collection(Collections.PROFILES).add(convertProfileFirebase(profileData, matchedUserIds));
}

function storeProfiles(numProfiles = 3, matchedUserIds = []) {
  const multipleProfilesData = JSON.parse(fs.readFileSync(multipleProfilePath, "utf8")).slice(0, numProfiles);
  return Promise.all(multipleProfilesData.map((profile, index) =>
    admin.firestore().collection(Collections.PROFILES)
        .add(convertProfileFirebase(profile, matchedUserIds, `Profile ${index}`)),
  ));
}

module.exports = { singleProfilePath, multipleProfilePath,
  convertProfileFirebase, storeMyProfile, storeOtherProfile, storeProfiles };
