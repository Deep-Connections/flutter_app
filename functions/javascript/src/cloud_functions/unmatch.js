
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { FieldValue } = require("firebase-admin/firestore");
const { Collections, FunctionErrors } = require("../constants");
const { chunkArray } = require("../helpers");

const db = admin.firestore();

exports.unmatch = functions.region("europe-west6").https.onCall(async (data, context) => {
  if (!context.auth || !context.auth.uid) {
    throw new functions.https.HttpsError(
        FunctionErrors.UNAUTHENTICATED,
        "The function must be called while authenticated.");
  }

  const userId = context.auth.uid;
  const chatId = data.chatId;

  if (!chatId) {
    throw new functions.https.HttpsError(FunctionErrors.INVALID_ARGUMENT, "chatId is required");
  }

  const profileDoc = await db.collection(Collections.PROFILES).doc(userId).get();
  if (!profileDoc.exists || !profileDoc.data().firstName) {
    throw new functions.https.HttpsError(FunctionErrors.NOT_FOUND, "User not found");
  }
  const firstName = profileDoc.data().firstName;

  let wasChatDeleted = false;
  let chatRef;
  await db.runTransaction(async (transaction) => {
    chatRef = db.collection(Collections.CHATS).doc(chatId);
    const chatDoc = await transaction.get(chatRef);
    if (!chatDoc.exists) {
      throw new functions.https.HttpsError(FunctionErrors.NOT_FOUND, "Chat not found");
    }

    const chatData = chatDoc.data();
    if (!chatData.participantIds.includes(userId)) {
      throw new functions.https.HttpsError(FunctionErrors.PERMISSION_DENIED, "User is not a participant in this chat");
    }
    transaction.update(db.collection(Collections.PROFILES).doc(userId), {
      numMatches: FieldValue.increment(-1),
    });

    if (chatData.participantIds.length === 1) {
      // if last user we delete the chat
      transaction.delete(chatRef);
      wasChatDeleted = true;
    } else {
      // remove the user from chat and create a message to notify the others about the unmatch
      transaction.update(chatRef, {
        participantIds: FieldValue.arrayRemove(userId),
        lastUpdatedAt: FieldValue.serverTimestamp(),
      });

      const messageRef = chatRef.collection(Collections.MESSAGES);
      transaction.create(messageRef.doc(), {
        chatId: chatId,
        runtimeType: "unmatch",
        createdAt: FieldValue.serverTimestamp(),
        lastUpdatedAt: FieldValue.serverTimestamp(),
        participantIds: chatData.participantIds.filter((id) => id !== userId),
        senderFirstName: firstName,
        senderId: userId,
      });
    }
  });

  if (wasChatDeleted) {
    const allMessagesOfChat = await chatRef.collection(Collections.MESSAGES).select().get();

    const deleteMessagesPromises = chunkArray(allMessagesOfChat.docs, 500).map((chunk) => {
      const batch = db.batch();
      chunk.forEach((doc) => batch.delete(doc.ref));
      return batch.commit();
    });
    await Promise.all(deleteMessagesPromises);
  }
  return { message: "Unmatched successfully" };
});
