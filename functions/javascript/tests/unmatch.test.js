
const test = require("firebase-functions-test")();
const admin = require("firebase-admin");

const { projectId } = require("./setup");

const unmatch = test.wrap(require("../src/cloud_functions/unmatch").unmatch);

const firebase = require("@firebase/testing");

const { storeMyProfile, storeOtherProfile } = require("./mock/mockProfile");
const assert = require("assert");

const { Collections, FunctionErrors } = require("../src/constants");
const { createMockChat, createMockMessage, defaultTimestamp } = require("./mock/mockChat");

const UID_1 = "test-uid-1";
const UID_2 = "test-uid-2";

async function unmatchUserFromChat(uid, chatId, review=null) {
  const context = {};
  if (uid) {
    context.auth = { uid: uid };
  }
  try {
    const json = { "chatId": chatId };
    if (review) {
      json.review = review;
    }
    return await unmatch(json, context);
  } catch (e) {
    return e;
  }
}

const db = admin.firestore();

describe("Unmatch", () => {
  let chatRef;

  beforeEach(async () => {
    await firebase.clearFirestoreData({ projectId });
    const promise = Promise.all([storeMyProfile(UID_1, [UID_2], "Bob"), storeMyProfile(UID_2, [UID_1], "Alice")]);
    chatRef = await createMockChat([UID_1, UID_2]);
    await promise;
  });

  it("can execute successfully", async () => {
    const result = await unmatchUserFromChat(UID_1, chatRef.id);
    assert.equal(result.message, "Unmatched successfully");

    let profile1 = db.collection(Collections.PROFILES).doc(UID_1).get();
    const profile2 = (await db.collection(Collections.PROFILES).doc(UID_2).get()).data();
    profile1 = (await profile1).data();
    assert.equal(profile1.numMatches, 0);
    assert.equal(profile1.matchedUserIds.length, 1);
    assert.equal(profile2.numMatches, 1);

    const chat = (await chatRef.get()).data();
    assert.equal(chat.participantIds.length, 1);
    assert.equal(chat.participantIds[0], UID_2);
    assert.equal(chat.originalParticipantIds.length, 2);
    assert.ok(chat.lastUpdatedAt > defaultTimestamp);
    assert.equal(chat.createdAt.toMillis(), defaultTimestamp.toMillis());
  });

  it("should create a unmatch message for the other users", async () => {
    const result = await unmatchUserFromChat(UID_1, chatRef.id);
    assert.equal(result.message, "Unmatched successfully");

    const messages = await db.collection(Collections.CHATS).doc(chatRef.id).collection(Collections.MESSAGES).get();
    assert.equal(messages.docs.length, 1);
    const message = messages.docs[0].data();
    assert.equal(message.senderFirstName, "Bob");
    assert.equal(message.senderId, UID_1);
    assert.equal(message.chatId, chatRef.id);
    assert.equal(message.participantIds.length, 1);
    assert.equal(message.participantIds[0], UID_2);
    assert.ok(message.createdAt.toDate() > new Date(2021, 1, 1));
    assert.equal(message.runtimeType, "unmatch");
  });

  it("should not be allowed if the user is not a participant", async () => {
    const otherUser = await storeOtherProfile();
    const result = await unmatchUserFromChat(otherUser.id, chatRef.id);
    assert.equal(result.code, FunctionErrors.PERMISSION_DENIED);
  });

  it("should delete chat if last user unmatches", async () => {
    await createMockMessage(chatRef, [UID_1, UID_2]);

    const result1 = await unmatchUserFromChat(UID_1, chatRef.id);
    assert.equal(result1.message, "Unmatched successfully");

    const result2 = await unmatchUserFromChat(UID_2, chatRef.id);
    assert.equal(result2.message, "Unmatched successfully");

    const chat = await chatRef.get();
    assert.ok(!chat.exists);

    const messages = await db.collection(Collections.CHATS).doc(chatRef.id).collection(Collections.MESSAGES).get();
    assert.equal(messages.docs.length, 0);

    const profile1 = (await db.collection(Collections.PROFILES).doc(UID_1).get()).data();
    const profile2 = (await db.collection(Collections.PROFILES).doc(UID_2).get()).data();
    assert.equal(profile1.numMatches, 0);
    assert.equal(profile2.numMatches, 0);
  });

  it("should be allowed to add a review", async () => {
    const review = {
      chatId: chatRef.id,
      text: "This is a review",
      rating: 5,
      reviewerId: UID_1,
      connectedToId: UID_2,
    };
    const result = await unmatchUserFromChat(UID_1, chatRef.id, review);
    assert.equal(result.message, "Unmatched successfully");

    const reviews = await db.collection(Collections.REVIEWS).get();
    assert.equal(reviews.docs.length, 1);
    const reviewDoc = reviews.docs[0].data();
    // reviewDoc createdAt should not be null
    assert.ok(reviewDoc.createdAt);
    delete reviewDoc.createdAt;
    delete review.createdAt;
    assert.deepEqual(reviewDoc, review);
  });
});
