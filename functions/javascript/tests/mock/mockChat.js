

const admin = require("firebase-admin");
const { Collections } = require("../../src/constants");
const { Timestamp } = require("firebase-admin/firestore");


const db = admin.firestore();

const defaultTimestamp = Timestamp.fromDate(new Date(2021, 1, 1));


async function createMockChat(participantIds, chatRef=null, timestamp=defaultTimestamp, score=2.5) {
  if (chatRef == null) {
    chatRef = db.collection(Collections.CHATS).doc();
  }
  await chatRef.set({
    participantIds: participantIds,
    originalParticipantIds: participantIds,
    createdAt: timestamp,
    lastUpdatedAt: timestamp,
    score: score,
  });
  return chatRef;
}

async function createMockMessage(chatRef, participantIds, senderId=null, text="Hello", timestamp=defaultTimestamp) {
  if (senderId == null) {
    senderId = participantIds[0];
  }
  return chatRef.collection(Collections.MESSAGES).add({
    chatId: chatRef.id,
    senderId: senderId,
    participantIds: participantIds,
    text: text,
    createdAt: timestamp,
    lastUpdatedAt: timestamp,
  });
}

module.exports = { createMockChat, createMockMessage, defaultTimestamp };
