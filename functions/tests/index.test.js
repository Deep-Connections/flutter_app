// https://timo-santi.medium.com/jest-testing-firebase-functions-with-emulator-suite-409907f31f39

const test = require("firebase-functions-test")();
const assert = require("assert");
const admin = require("firebase-admin");

const projectId = "deep-connections-7796d";

process.env.GCLOUD_PROJECT = "deep-connections-7796d";
process.env.FIRESTORE_EMULATOR_HOST = "localhost:8080";
admin.initializeApp({ projectId });

// make sure cloud functions don't reinitialize firebase app
require("sinon").stub(admin, "initializeApp");

const createInitialMatch = test.wrap(require("../index").createInitialMatch);


const firebase = require("@firebase/testing");
const fs = require("fs");
const { Collections, FunctionErrors } = require("../constants");

const UID = "test-uid";

const context = {
  auth: {
    uid: UID,
    token: {},
  },
};

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

function storeMyProfile(matchedUserIds = null) {
  const profileData = JSON.parse(fs.readFileSync(
      "../scripts/generated/single_profile.json", "utf8",
  ));
  return admin.firestore().collection(Collections.PROFILES)
      .doc(UID).set(convertProfileFirebase(profileData, matchedUserIds));
}

function storeProfile(matchedUserIds = []) {
  const profileData = JSON.parse(fs.readFileSync("../scripts/generated/single_profile.json", "utf8"));
  const gender = profileData.gender;
  profileData.gender = profileData.genderPreferences[0];
  profileData.genderPreferences = [gender];
  return admin.firestore().collection(Collections.PROFILES).add(convertProfileFirebase(profileData, matchedUserIds));
}

function storeProfiles(numProfiles = 3, matchedUserIds = []) {
  const multipleProfilesData = JSON.parse(fs.readFileSync(
      "../scripts/generated/multiple_profile.json", "utf8"),
  ).slice(0, numProfiles);
  return Promise.all(multipleProfilesData.map((profile, index) =>
    admin.firestore().collection(Collections.PROFILES)
        .add(convertProfileFirebase(profile, matchedUserIds, `Profile ${index}`)),
  ));
}

async function createMatch() {
  try {
    return await createInitialMatch({}, context);
  } catch (e) {
    return e;
  }
}

async function hasNoMatch() {
  const e = await createMatch();
  assert.equal(e.code, FunctionErrors.NOT_FOUND, "Should not find a match");
}

const bestProfileName = "Profile 0";
const bestProfileScore = 16;

describe("InitialMatch", () => {
  beforeEach(async () => {
    await firebase.clearFirestoreData({ projectId });
  });

  after(async () => {
    firebase.clearFirestoreData({ projectId });
  });

  it("can create successfully", async () => {
    await Promise.all([storeMyProfile(), storeProfile()]);

    const result = await createInitialMatch({}, context);
    assert.equal(result.message, "Match created");
    const match = await admin.firestore().collection(Collections.CHATS).doc(result.matchId).get();
    assert.equal(match.data().participantIds[0], UID);
  });

  it("should not find yourself", async () => {
    await storeMyProfile([]);
    await hasNoMatch();
  });

  it("should prefer people with less matches", async () => {
    const promise = Promise.all([storeMyProfile(), storeProfile(["1", "2", "3", "4"])]);
    const ref = await storeProfile(["1", "2", "3"]);
    await promise;

    const result = await createInitialMatch({}, context);
    const match = await admin.firestore().collection(Collections.CHATS).doc(result.matchId).get();
    assert.equal(match.data().participantIds[1], ref.id);
  });

  it("should find the best profile by computing scores", async () => {
    await storeMyProfile();
    await storeProfiles(10, ["1"]);

    const result = await createInitialMatch({}, context);
    const match = await admin.firestore().collection(Collections.CHATS).doc(result.matchId).get();
    const otherProfile = await admin.firestore().collection(Collections.PROFILES)
        .doc(match.data().participantIds[1]).get();
    assert.equal(otherProfile.data().firstName, bestProfileName);
    assert.equal(Math.floor(match.data().score), bestProfileScore);
  });

  it("should not find profiles without matches, as these are not fully setup", async () => {
    await storeMyProfile();
    await storeProfiles(10, null);

    await hasNoMatch();
  });

  it("should not be created without a date of birth or language", async () => {
    const profileData = convertProfileFirebase(
        JSON.parse(fs.readFileSync("../scripts/generated/single_profile.json", "utf8")),
    );
    const languageCodes = profileData.languageCodes;
    delete profileData.languageCodes;
    const docRef = admin.firestore().collection(Collections.PROFILES).doc(UID);
    await Promise.all([docRef.set(profileData), storeProfile()]);
    const error = await createMatch();
    assert.equal(error.code, FunctionErrors.FAILED_PRECONDITION);
    profileData.languageCodes = languageCodes;
    delete profileData.dateOfBirth;
    await docRef.set(profileData);
    const error2 = await createMatch();
    assert.equal(error2.code, FunctionErrors.FAILED_PRECONDITION);
  });

  it("should not match the same user twice", async () => {
    const otherProfiles = await storeProfiles(3, [UID]);
    await storeMyProfile(otherProfiles.map((profile) => profile.id));
    await hasNoMatch();
  });

  it("In a second step it should match users that don't speak the same language", async () => {
    const profileData = JSON.parse(fs.readFileSync("../scripts/generated/single_profile.json", "utf8"));
    profileData.languageCodes = ["ak"];
    await admin.firestore().collection(Collections.PROFILES).doc(UID).set(convertProfileFirebase(profileData, []));
    const otherProfile = await storeProfile();
    const result = await createInitialMatch({}, context);
    const match = await admin.firestore().collection(Collections.CHATS).doc(result.matchId).get();
    assert.equal(match.data().participantIds[1], otherProfile.id);
  });

  it("should forbid multiple concurrent calls", async () => {
    await Promise.all([storeMyProfile(), storeProfile()]);
    const results = await Promise.all([createMatch(), createMatch(), createMatch()]);
    const success = results.filter((result) => result.message === "Match created");
    assert.equal(success.length, 1);
    const failures = results.filter((result) => result.code === FunctionErrors.ALREADY_EXISTS);
    assert.equal(failures.length, 2);
  });
});

