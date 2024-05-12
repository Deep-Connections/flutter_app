

const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { FieldValue } = require("firebase-admin/firestore");
const { Collections, FunctionErrors } = require("./constants");

admin.initializeApp();

const ageDifference = 5;
const maxNumMatches = 5;

const db = admin.firestore();

async function getPotentialMatches(profileData, userId) {
  const dateOfBirth = profileData.dateOfBirth.toDate();
  const fiveYearsOlder = new Date(dateOfBirth);
  fiveYearsOlder.setFullYear(fiveYearsOlder.getFullYear() + ageDifference);
  const fiveYearsYounger = new Date(dateOfBirth);
  fiveYearsYounger.setFullYear(fiveYearsYounger.getFullYear() - ageDifference);
  const matchedUserIds = (profileData.matchedUserIds || []);

  let profiles = (await db.collection(Collections.PROFILES)
      .where("numMatches", "<", maxNumMatches)
      .where("languageCodes", "array-contains-any", profileData.languageCodes.slice(0, 10))
      .where("dateOfBirth", "<=", fiveYearsOlder)
      .where("dateOfBirth", ">=", fiveYearsYounger)
      .orderBy("numMatches", "asc")
      .limit(100).get()).docs.filter((doc) => doc.id !== userId);

  if (profiles.filter((doc) => !matchedUserIds.includes(doc.id)).length === 0) {
    // get one more user than the number of matched users (max 100)
    const limit = Math.min(matchedUserIds.length + 2, 100);
    profiles = (await db.collection(Collections.PROFILES)
        // only find profiles that have been matched before, to exclude unfinished profiles
        .where("numMatches", ">=", 0)
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
    throw new functions.https.HttpsError(
        FunctionErrors.UNAUTHENTICATED,
        "The function must be called while authenticated.");
  }

  const userId = context.auth.uid;

  const profileRef = db.collection(Collections.PROFILES).doc(userId);
  let currentProfile;
  await db.runTransaction(async (transaction) => {
    const profileDoc = await transaction.get(profileRef);
    if (!profileDoc.exists) {
      throw new functions.https.HttpsError(FunctionErrors.FAILED_PRECONDITION, "Current user's profile not found");
    }
    currentProfile = profileDoc.data();

    if (!currentProfile.dateOfBirth) {
      throw new functions.https.HttpsError(FunctionErrors.FAILED_PRECONDITION, "User profile missing dateOfBirth");
    }

    if (!currentProfile.languageCodes || currentProfile.languageCodes.length === 0) {
      throw new functions.https.HttpsError(FunctionErrors.FAILED_PRECONDITION, "User profile missing languageCodes");
    }

    const lastMatchedAt = currentProfile.lastMatchedAt;
    let hoursSinceLastMatch = 0;
    if (lastMatchedAt) {
      hoursSinceLastMatch = (new Date() - lastMatchedAt.toDate()) / (1000 * 60 * 60);
    }

    if (!lastMatchedAt || hoursSinceLastMatch >= 24) {
      transaction.update(profileRef, { lastMatchedAt: FieldValue.serverTimestamp() });
    } else {
      throw new functions.https.HttpsError(FunctionErrors.ALREADY_EXISTS, "User has already been matched today");
    }
  });

  const profiles = await getPotentialMatches(currentProfile, userId);

  const profilesWithScores = sortProfilesByMatchScore(profiles.map((doc) => {
    return { id: doc.id, ...doc.data() };
  }), currentProfile);

  const matchedUserIds = currentProfile.matchedUserIds || [];

  // find first profile that has not been matched yet
  const matchedUser = profilesWithScores.find((profileWScore) => !matchedUserIds.includes(profileWScore.profile.id));

  if (!matchedUser) {
    throw new functions.https.HttpsError(FunctionErrors.NOT_FOUND, "No profiles found");
  }

  const matchUserId = matchedUser.profile.id;

  const match = {
    participantIds: [userId, matchUserId],
    createdAt: FieldValue.serverTimestamp(),
    score: profilesWithScores[0].score,
  };

  const matchDocRef = db.collection(Collections.CHATS).doc();
  const matchId = matchDocRef.id;
  await matchDocRef.set(match);
  await profileRef.update({
    numMatches: FieldValue.increment(1),
    matchedUserIds: FieldValue.arrayUnion(matchUserId),
    lastMatchedAt: FieldValue.serverTimestamp(),
  });
  await db.collection(Collections.PROFILES).doc(matchUserId)
      .update({
        numMatches: FieldValue.increment(1),
        matchedUserIds: FieldValue.arrayUnion(userId),
        lastMatchedAt: FieldValue.serverTimestamp(),
      });

  return { message: "Match created", matchId: matchId };
});

