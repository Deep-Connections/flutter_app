
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { Collections, FieldName, FunctionErrors } = require("../constants");
const { chunkArray } = require("../helpers");

const db = admin.firestore();
const auth = admin.auth();
const bucket = admin.storage().bucket();

async function deleteAccountByUserId(userId) {
  let allMessagesOfUser = db.collectionGroup(Collections.MESSAGES)
      .where(FieldName.SENDER_ID, "==", userId).select().get();

  const allChatsOfUser = await db.collection(Collections.CHATS)
      .where(FieldName.PARTICIPANT_IDS, "array-contains", userId).get();

  allMessagesOfUser = await allMessagesOfUser;

  const deleteMessagesPromises = chunkArray(allMessagesOfUser.docs, 500).map((chunk) => {
    const batch = db.batch();
    chunk.forEach((doc) => batch.delete(doc.ref));
    return batch.commit();
  });

  const removeChatParticipantPromises = chunkArray(allChatsOfUser.docs, 500).map((chunk) => {
    chunk.forEach((doc) => {
      const batch = db.batch();
      if (doc.data().participantIds.length === 1) {
        batch.delete(doc.ref);
      } else {
        batch.update(doc.ref, {
          participantIds: admin.firestore.FieldValue.arrayRemove(userId),
          lastUpdatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
      return batch.commit();
    });
  });

  const deleteProfilePromise = db.collection(Collections.PROFILES).doc(userId).delete();

  const deletUserPromise = auth.deleteUser(userId);

  const deletFilesPromise = bucket.deleteFiles({ prefix: `profile_images/${userId}/` });

  await Promise.all([deleteProfilePromise,
    deletUserPromise,
    deletFilesPromise,
  ] + deleteMessagesPromises + removeChatParticipantPromises);
}

exports.deleteAccountByUserId = deleteAccountByUserId;

exports.deleteAccount = functions.region("europe-west6").https.onCall(async (data, context) => {
  if (!context.auth || !context.auth.uid) {
    throw new functions.https.HttpsError(
        FunctionErrors.UNAUTHENTICATED,
        "The function must be called while authenticated.");
  }

  const userId = context.auth.uid;

  await deleteAccountByUserId(userId);
  return { message: "Account deleted" };
});
