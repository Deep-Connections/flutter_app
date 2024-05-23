
const test = require("firebase-functions-test")();
const admin = require("firebase-admin");

const projectId = "delete-account-test";

process.env.GCLOUD_PROJECT = "deep-connections-7796d";
process.env.FIRESTORE_EMULATOR_HOST = "localhost:8080";
process.env.FIREBASE_AUTH_EMULATOR_HOST = "localhost:9099";
process.env.FIREBASE_STORAGE_EMULATOR_HOST = "localhost:9199";

admin.initializeApp({ projectId,
  credential: admin.credential.applicationDefault(),
  storageBucket: "deep-connections-7796d.appspot.com",
});


const deleteAccount = test.wrap(require("../src/cloud_functions/deleteAccount").deleteAccount);

const firebase = require("@firebase/testing");


const assert = require("assert");

const { Collections } = require("../src/constants");
const { createMockChat, createMockMessage } = require("./mock/mockChat");

const UID_1 = "test-uid-1";
const UID_2 = "test-uid-2";

const db = admin.firestore();

const bucket = admin.storage().bucket();
const auth = admin.auth();

async function createChat(participantIds) {
  const chatRef = db.collection(Collections.CHATS).doc();
  const chatPromise = createMockChat(participantIds, chatRef);

  const messagePromise = createMockMessage(chatRef, participantIds);

  const receivingParticipantIds = participantIds.reverse();
  const receivingMessagePromise = createMockMessage(chatRef, receivingParticipantIds);

  await Promise.all([chatPromise, messagePromise, receivingMessagePromise]);
  return chatRef;
}

async function deleteUser(userId) {
  try {
    await admin.auth().deleteUser(userId);
  } catch (e) {/* ignore */}
}

async function createMockUserData(userId, otherUserId) {
  await Promise.all([
    auth.createUser({ uid: userId }),
    bucket.file(`profile_images/${userId}/image.jpg`).save("test"),
    db.collection(Collections.PROFILES).doc(userId).set({
      firstName: userId,
    }),
    // create a chat with another user, and a chat with only the to be deleted user
    createChat([userId, otherUserId]),
    createChat([userId]),
  ]);
}

describe("Delete account", () => {
  beforeEach(async () => {
    await Promise.all([
      firebase.clearFirestoreData({ projectId }),
      bucket.deleteFiles({}),
      deleteUser(UID_1),
      deleteUser(UID_2),
    ]);
  });

  it("removes all sensitive data of user", async () => {
    await createMockUserData(UID_1, UID_2);
    await deleteAccount({}, { auth: { uid: UID_1 } });

    const allChatsPromise = db.collection(Collections.CHATS).get();
    const allMessagesPromise = db.collectionGroup(Collections.MESSAGES).get();
    const profilePromise = db.collection(Collections.PROFILES).doc(UID_1).get();
    const filesPromise = bucket.getFiles({ prefix: `profile_images/${UID_1}/` });

    const allMessages = await allMessagesPromise;
    const allChats = await allChatsPromise;
    // Message from the other user remains
    assert.equal(allMessages.size, 1);
    assert.equal(allMessages.docs.filter((doc) => doc.data().senderId === UID_1).length, 0);

    // the chat with the other user remains
    assert.equal(allChats.size, 1);
    assert.equal(allChats.docs.filter((doc) => doc.data().participantIds.includes(UID_1)).length, 0);

    // check image is deleted
    assert.equal((await filesPromise)[0].length, 0);

    assert.equal((await profilePromise).exists, false);
    try {
      await admin.auth().getUser(UID_1);
      assert.fail("User should be deleted");
    } catch (e) {
      assert.equal(e.code, "auth/user-not-found");
    }
  });

  it("works even if user has no data", async () => {
    await auth.createUser({ uid: UID_1 });
    await deleteAccount({}, { auth: { uid: UID_1 } });
  });

  it("should leave the other user's data intact", async () => {
    await Promise.all([
      createMockUserData(UID_1, UID_2),
      createMockUserData(UID_2, UID_1),
    ]);
    await deleteAccount({}, { auth: { uid: UID_1 } });

    const profile2 = db.collection(Collections.PROFILES).doc(UID_2).get();
    const constChatsOfUser2 = db.collection(Collections.CHATS).where("participantIds", "array-contains", UID_2).get();
    const constMessagesOfUser2 = db.collectionGroup(Collections.MESSAGES).where("senderId", "==", UID_2).get();
    const user2 = admin.auth().getUser(UID_2);
    const imagesOfUser2 = bucket.getFiles({ prefix: `profile_images/${UID_2}/` });
    assert.equal((await profile2).data().firstName, UID_2);
    assert.equal((await constChatsOfUser2).size, 3);
    assert.equal((await constMessagesOfUser2).size, 4);
    assert.equal((await user2).uid, UID_2);
    assert.equal((await imagesOfUser2)[0].length, 1);
  });
});
