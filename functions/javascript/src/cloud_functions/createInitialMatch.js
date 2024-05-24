
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { FieldValue } = require("firebase-admin/firestore");
const { Collections, FunctionErrors } = require("../constants");

const db = admin.firestore();

const { getPotentialMatches, sortProfilesByMatchScore } = require("../matchComputation");

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

    if (!currentProfile.gender) {
      throw new functions.https.HttpsError(FunctionErrors.FAILED_PRECONDITION, "User profile missing gender");
    }

    if (!currentProfile.genderPreferences || currentProfile.genderPreferences.length === 0) {
      throw new functions.https.HttpsError(
          FunctionErrors.FAILED_PRECONDITION, "User profile missing genderPreferences",
      );
    }

    const lastMatchedAt = currentProfile.lastMatchedAt;
    let hoursSinceLastMatch = 0;
    if (lastMatchedAt) {
      hoursSinceLastMatch = (new Date() - lastMatchedAt.toDate()) / (1000 * 60 * 60);
    }

    if (!lastMatchedAt || hoursSinceLastMatch >= 24) {
      const numMatches = currentProfile.numMatches || 0;
      transaction.update(profileRef, { lastMatchedAt: FieldValue.serverTimestamp(), numMatches: numMatches });
    } else {
      throw new functions.https.HttpsError(FunctionErrors.ALREADY_EXISTS, "User has already been matched today");
    }
  });

  const profiles = await getPotentialMatches(db, currentProfile, userId);

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
    originalParticipantIds: [userId, matchUserId],
    createdAt: FieldValue.serverTimestamp(),
    lastUpdatedAt: FieldValue.serverTimestamp(),
    score: profilesWithScores[0].score,
  };

  const matchDocRef = db.collection(Collections.CHATS).doc();
  const matchId = matchDocRef.id;
  await matchDocRef.set(match);
  await profileRef.update({
    numMatches: FieldValue.increment(1),
    matchedUserIds: FieldValue.arrayUnion(matchUserId),
  });
  await db.collection(Collections.PROFILES).doc(matchUserId)
      .update({
        numMatches: FieldValue.increment(1),
        matchedUserIds: FieldValue.arrayUnion(userId),
      });

  return { message: "Match created", matchId: matchId };
});
