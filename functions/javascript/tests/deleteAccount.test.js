
const test = require("firebase-functions-test")();
const admin = require("firebase-admin");

const projectId = "account-delete-test";

process.env.GCLOUD_PROJECT = "deep-connections-7796d";
process.env.FIRESTORE_EMULATOR_HOST = "localhost:8080";
process.env.FIREBASE_AUTH_EMULATOR_HOST = "localhost:9099";
admin.initializeApp({ projectId,
  credential: admin.credential.applicationDefault() });

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
    const deleteFirestorePromise = firebase.clearFirestoreData({ projectId });
    try {
      await admin.auth().createUser({ uid: UID_1 });
    } catch (e) {
      console.log(e);
    }
    await deleteFirestorePromise;
  });

  it("removes all sensitive data of user", async () => {
    let profilePromise = db.collection(Collections.PROFILES).doc(UID_1).set({
      firstName: "Alice",
    });

    // create a chat with another user, and a chat with only the to be deleted user
    await Promise.all([createChat([UID_1, UID_2]), createChat([UID_1]), profilePromise]);

    await deleteAccount({}, { auth: { uid: UID_1 } });

    const allChatsPromise = db.collection(Collections.CHATS).get();
    const allMessagesPromise = db.collectionGroup(Collections.MESSAGES).get();
    profilePromise = db.collection(Collections.PROFILES).doc(UID_1).get();

    const allMessages = await allMessagesPromise;
    const allChats = await allChatsPromise;
    // Message from the other user remains
    assert.equal(allMessages.size, 1);
    assert.equal(allMessages.docs.filter((doc) => doc.data().senderId === UID_1).length, 0);

    // the chat with the other user remains
    assert.equal(allChats.size, 1);
    assert.equal(allChats.docs.filter((doc) => doc.data().participantIds.includes(UID_1)).length, 0);

    assert.equal((await profilePromise).exists, false);
    try {
      await admin.auth().getUser(UID_1);
      await admin.auth().deleteUser(UID_1);
      assert.fail("User should be deleted");
    } catch (e) {
      assert.equal(e.code, "auth/user-not-found");
    }
  });

  it("works even if user has no profile", async () => {
    await deleteAccount({}, { auth: { uid: UID_1 } });
  });
});
