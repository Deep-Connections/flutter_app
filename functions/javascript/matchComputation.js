const { AllQuestions } = require("./generated_flutter_constants");
const { Collections, FunctionErrors } = require("./constants");
const functions = require("firebase-functions");


const ageDifference = 5;
const maxNumMatches = 5;

async function getPotentialMatches(db, profileData, userId) {
  const dateOfBirth = profileData.dateOfBirth.toDate();
  const fiveYearsOlder = new Date(dateOfBirth);
  fiveYearsOlder.setFullYear(fiveYearsOlder.getFullYear() + ageDifference);
  const fiveYearsYounger = new Date(dateOfBirth);
  fiveYearsYounger.setFullYear(fiveYearsYounger.getFullYear() - ageDifference);
  const matchedUserIds = (profileData.matchedUserIds || []);

  let profiles = (await db.collection(Collections.PROFILES)
      .where("numMatches", "<", maxNumMatches)
      .where("gender", "in", profileData.genderPreferences.slice(0, 10))
      .where("genderPreferences", "array-contains", profileData.gender)
      .where("dateOfBirth", "<=", fiveYearsOlder)
      .where("dateOfBirth", ">=", fiveYearsYounger)
      .orderBy("numMatches", "asc")
      .limit(100).get()).docs.filter((doc) => doc.id !== userId);

  profiles = profiles.filter((profile) =>
    profile.data().languageCodes.some((language) => profileData.languageCodes.includes(language)));

  if (profiles.filter((doc) => !matchedUserIds.includes(doc.id)).length === 0) {
    // To make sure we find a new user, search for more users than we have already matched with
    const limit = matchedUserIds.length + 2;
    profiles = (await db.collection(Collections.PROFILES)
        .where("numMatches", ">=", 0) // to exclude unfinished profiles that don't have numMatches
        .where("gender", "in", profileData.genderPreferences.slice(0, 10))
        .where("genderPreferences", "array-contains", profileData.gender)
        .orderBy("numMatches", "asc")
        .limit(limit).get()).docs.filter((doc) => doc.id !== userId);

    if (profiles.filter((doc) => !matchedUserIds.includes(doc.id).length) === 0) {
      db.collection(Collections.PROFILES).doc(userId).update({ numMatches: 0 });
      throw new functions.https.HttpsError(FunctionErrors.NOT_FOUND, "No matching profiles found");
    }
  }

  return profiles;
}

function isObject(value) {
  return value && typeof value === "object" && value.constructor === Object;
}

function isNumber(value) {
  return typeof value === "number" && !isNaN(value);
}

function computeMatchScore(profile1, profile2) {
  let score = 0;
  if (isObject(profile1.questions) && isObject(profile2.questions)) {
    for (const id of AllQuestions) {
      if (Object.hasOwn(profile1.questions, id) && Object.hasOwn(profile2.questions, id)) {
        try {
          const confidence1 = profile1.questions[id].confidence;
          const confidence2 = profile2.questions[id].confidence;
          if (isNumber(confidence1) && isNumber(confidence2)) {
            score += 0.5 - Math.abs(confidence1 - confidence2);
            continue;
          }
          const choices1 = profile1.questions[id].choices;
          const choices2 = profile2.questions[id].choices;
          if (Array.isArray(choices1) && Array.isArray(choices2)) {
            let subScore = 0;
            for (const choice of choices1) {
              if (choices2.includes(choice)) {
                subScore++;
              }
            }
            score += subScore * 2 / (choices1.length + choices2.length);
            continue;
          }
        } catch (e) {
          console.log(e);
        }
      }
    }
    return score;
  }
}

function sortProfilesByMatchScore(profiles, user) {
  const profilesWithScores = profiles.map((profile) => ({
    profile,
    score: computeMatchScore(user, profile),
  }));

  profilesWithScores.sort((a, b) => b.score - a.score);

  // console.log(profilesWithScores.map((item) => item.profile.firstName + ", score: " + item.score));

  return profilesWithScores;
}

module.exports = { getPotentialMatches, sortProfilesByMatchScore };
