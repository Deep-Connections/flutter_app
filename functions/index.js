

const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { Firestore } = require("firebase-admin/firestore");

admin.initializeApp();

const ageDifference = 5;

const db = admin.firestore();

async function getPotentialMatches(profileData, userId) {
  const dateOfBirth = profileData.dateOfBirth.toDate();
  const fiveYearsOlder = new Date(dateOfBirth);
  fiveYearsOlder.setFullYear(fiveYearsOlder.getFullYear() + ageDifference);
  const fiveYearsYounger = new Date(dateOfBirth);
  fiveYearsYounger.setFullYear(fiveYearsYounger.getFullYear() - ageDifference);

  let profiles = (await db.collection("profiles")
      .where("numMatches", "<", 5)
      .where("languageCodes", "array-contains-any", profileData.languageCodes)
      .where("dateOfBirth", "<=", fiveYearsOlder)
      .where("dateOfBirth", ">=", fiveYearsYounger)
      .orderBy("numMatches", "asc")
      .limit(100).get()).docs;

  profiles = profiles.filter((doc) => doc.id !== userId);

  if (profiles.length === 0) {
    throw new functions.https.HttpsError("not-found", "No profiles found");
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
    for (const key in profile1.questions) {
      if (Object.hasOwn(profile1.questions, key) && Object.hasOwn(profile2.questions, key)) {
        try {
          const confidence1 = profile1.questions[key].confidence;
          const confidence2 = profile2.questions[key].confidence;
          if (isNumber(confidence1) && isNumber(confidence2)) {
            score += 0.5 - Math.abs(confidence1 - confidence2);
            continue;
          }
          const choices1 = profile1.questions[key].choices;
          const choices2 = profile2.questions[key].choices;
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

exports.createInitialMatch = functions.region("europe-west6").https.onCall(async (data, context) => {
  if (!context.auth || !context.auth.uid) {
    throw new functions.https.HttpsError("unauthenticated", "The function must be called while authenticated.");
  }

  const userId = context.auth.uid;


  const profileRef = db.collection("profiles").doc(userId);
  const currentProfile = (await profileRef.get()).data();

  if (!currentProfile) {
    throw new functions.https.HttpsError("not-found", "Current user's profile not found");
  }

  // if (currentProfile.numMatches >= 1) {
  //     throw new functions.https.HttpsError('failed-precondition', 'Match already exists');
  // }

  const profiles = await getPotentialMatches(currentProfile, userId);

  const profilesWithScores = sortProfilesByMatchScore(profiles.map((doc) => {
    return {id: doc.id, ...doc.data()};
  }), currentProfile);

  const otherUserId = profilesWithScores[0].profile.id;

  const match = {
    participantIds: [userId, otherUserId],
    createdAt: Firestore.FieldValue.serverTimestamp(),
    score: profilesWithScores[0].score,
  };

  const matchDocRef = db.collection("matches").doc();
  const matchId = matchDocRef.id;
  await matchDocRef.set(match);
  await profileRef.update({numMatches: Firestore.FieldValue.increment(1)});
  await db.collection("profiles").doc(otherUserId).update({numMatches: Firestore.FieldValue.increment(1)});

  return {message: "Match created", matchId: matchId};
});

