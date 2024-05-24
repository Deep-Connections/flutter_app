
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { FieldValue } = require("firebase-admin/firestore");
const { Collections, FieldName, FunctionErrors } = require("../constants");
const { chunkArray } = require("../helpers");
const db = admin.firestore();

const auth = admin.auth();
const bucket = admin.storage().bucket();

async function deleteMessages(userId) {
  const allMessagesOfUser = await db.collectionGroup(Collections.MESSAGES)
      .where(FieldName.SENDER_ID, "==", userId).select(FieldName.RUNTIME_TYPE).get();

  return Promise.all(chunkArray(allMessagesOfUser.docs, 500).map((chunk) => {
    const batch = db.batch();
    chunk.forEach((doc) => {
      // make sure the delete message we've just created are not deleted
      if (doc.data().runtimeType !== "delete") {
        batch.delete(doc.ref);
      }
    });

    return batch.commit();
  }));
}

async function deleteChats(userId, profilePromise) {
  const allChatsOfUser = await db.collection(Collections.CHATS)
      .where(FieldName.PARTICIPANT_IDS, "array-contains", userId).select(FieldName.PARTICIPANT_IDS).get();
  const firstName = await profilePromise.then((doc) => {
    if (!doc.exists || !doc.data().firstName) {
      return null;
    }
    return doc.data().firstName;
  });

  return Promise.all(chunkArray(allChatsOfUser.docs, 250).map((chunk) => {
    chunk.forEach((chat) => {
      const batch = db.batch();
      if (chat.data().participantIds.length === 1) {
        batch.delete(chat.ref);
      } else {
        batch.update(chat.ref, {
          participantIds: FieldValue.arrayRemove(userId),
          lastUpdatedAt: FieldValue.serverTimestamp(),
        });
        if (firstName !== null) {
          batch.create(db.collection(Collections.CHATS).doc(chat.id).collection(Collections.MESSAGES).doc(), {
            chatId: chat.id,
            runtimeType: "delete",
            createdAt: FieldValue.serverTimestamp(),
            lastUpdatedAt: FieldValue.serverTimestamp(),
            participantIds: chat.data().participantIds.filter((id) => id !== userId),
            senderFirstName: firstName,
            senderId: userId,
          });
        }
      }
      return batch.commit();
    });
  }));
}

async function deleteAccountByUserId(userId) {
  const profilePromise = db.collection(Collections.PROFILES).doc(userId).get();

  const deleteMessagesPromise = deleteMessages(userId);

  const deleteChatsPromise = deleteChats(userId, profilePromise);

  const deletUserPromise = auth.deleteUser(userId);

  const deletFilesPromise = bucket.deleteFiles({ prefix: `profile_images/${userId}/` });

  await profilePromise;
  const deleteProfilePromise = db.collection(Collections.PROFILES).doc(userId).delete();

  await Promise.all([
    deleteProfilePromise,
    deletUserPromise,
    deletFilesPromise,
    deleteMessagesPromise,
    deleteChatsPromise,
  ]);
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
