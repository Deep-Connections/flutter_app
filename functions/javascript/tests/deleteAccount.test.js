
const test = require("firebase-functions-test")();
const admin = require("firebase-admin");

const projectId = "account-delete-test";

process.env.GCLOUD_PROJECT = "deep-connections-7796d";
process.env.FIRESTORE_EMULATOR_HOST = "localhost:8080";
admin.initializeApp({ projectId });

// make sure cloud functions don't reinitialize firebase app
require("sinon").stub(admin, "initializeApp");

const deleteAccount = test.wrap(require("../index").deleteAccount);

const firebase = require("@firebase/testing");


const assert = require("assert");

const { Collections } = require("../src/constants");
const { createMockChat, createMockMessage } = require("./mock/mockChat");

const UID_1 = "test-uid-1";
const UID_2 = "test-uid-2";

const db = admin.firestore();

async function createChat(participantIds) {
  const chatRef = db.collection(Collections.CHATS).doc();
  const chatPromise = createMockChat(participantIds, chatRef);

  const messagePromise = createMockMessage(chatRef, participantIds);

  const receivingParticipantIds = participantIds.reverse();
  const receivingMessagePromise = createMockMessage(chatRef, receivingParticipantIds);

  await Promise.all([chatPromise, messagePromise, receivingMessagePromise]);
  return chatRef;
}

describe("Delete account", () => {
  beforeEach(async () => {
    await firebase.clearFirestoreData({ projectId });
  });

  it("removes all sensitive data of user", async () => {
    // await admin.auth().createUser({
    //   uid: UID_1,
    // });

    const profilePromise = db.collection(Collections.PROFILES).doc(UID_1).set({
      firstName: "Alice",
    });

    await Promise.all([createChat([UID_1, UID_2]), createChat([UID_1]), profilePromise]);


    await deleteAccount({}, { auth: { uid: UID_1 } });

    const allChatsPromise = db.collection(Collections.CHATS).get();
    const allMessagesPromise = db.collectionGroup(Collections.MESSAGES).get();
    const profile = db.collection(Collections.PROFILES).doc(UID_1).get();

    const allMessages = await allMessagesPromise;
    const allChats = await allChatsPromise;
    // Message from the other user remains
    assert.equal(allMessages.size, 1);
    assert.equal(allMessages.docs.filter((doc) => doc.data().senderId === UID_1).length, 0);

    // the chat with the other user remains, the chat with only the user is deleted
    assert.equal(allChats.size, 1);
    assert.equal(allChats.docs.filter((doc) => doc.data().participantIds.includes(UID_1)).length, 0);

    assert.equal((await profile).exists, false);
  });

  it("works even if user has no profile", async () => {
    await deleteAccount({}, { auth: { uid: UID_1 } });
  });
});
