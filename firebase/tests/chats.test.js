const assert = require("assert");
const firebase = require("@firebase/testing");
const { getFirestore, getAdminFirestore, clearFirestoreData } = require('./setup');
const FieldValue = firebase.firestore.FieldValue;
const { Collections } = require('./constants');

const UID = "testUser";
const myAuth = { uid: UID, email: "example@gmail.com" };
const wrongAuth = { uid: "wrongUser", email: "wrong@gmail.com" };
const chatId = "chat1";

function updateChatData() {
    return {
        chatInfos: {
            testUser: {
                lastRead: firebase.firestore.Timestamp.now(),
            }
        }
    };
}

describe("Chat functionality", () => {

    beforeEach(async () => { 
        await clearFirestoreData();
        const adminDb = getAdminFirestore();
        await adminDb.collection(Collections.CHATS).doc(chatId).set({
            participantIds: [UID, "otherUser"],
            createdAt: firebase.firestore.Timestamp.now()
        });
    });

    it("can fetch a list of chats where the user is a participant", async () => {
        const db = getFirestore(myAuth);
        const chatsRef = db.collection(Collections.CHATS);

        const query = chatsRef.doc(chatId);
        const chatDoc = await query.get();
        await firebase.assertSucceeds(chatDoc);
        assert.equal(chatDoc.data().participantIds.length, 2);
        const query2 = chatsRef.where("participantIds", "array-contains", myAuth.uid);
        const chatDocs = await query2.get();
        await firebase.assertSucceeds(chatDocs);
        assert.equal(chatDocs.docs.length, 1);

    });

    it("forbids access to existing chats where the user is not a participant", async () => {
        const db = getFirestore(wrongAuth);
        const chatsRef = db.collection(Collections.CHATS);
        const query = chatsRef.doc(chatId);
        await firebase.assertFails(query.get());

        const query2 = chatsRef.where("participantIds", "array-contains", myAuth.uid);
        await firebase.assertFails(query2.get());
    });

    it("allows updating a chat when the user is a participant and only their own chatInfo is updated", async () => {
        const db = getFirestore(myAuth);
        const chatRef = db.collection(Collections.CHATS).doc(chatId);
        await firebase.assertSucceeds(chatRef.update(updateChatData()));
        let updateData = updateChatData();
        let differentDate = new Date();
        differentDate.setSeconds(differentDate.getSeconds() + 1);
        updateData.chatInfos.testUser.lastRead = firebase.firestore.Timestamp.fromDate(differentDate);
        await firebase.assertSucceeds(chatRef.update(updateData));
    });

    it("forbids writing wrong values to chatInfos", async () => {
        const db = getFirestore(myAuth);
        const chatRef = db.collection(Collections.CHATS).doc(chatId);
        let updateData = updateChatData();
        updateData.chatInfos.testUser.lastRead = "wrongValue";
        await firebase.assertFails(chatRef.update(updateData));
        updateData.chatInfos.testUser = "wrongValue";
        await firebase.assertFails(chatRef.update(updateData));
        updateData.chatInfos = "wrongValue";
        await firebase.assertFails(chatRef.update(updateData));

        let otherUserData = {
            chatInfos: {
                otherUser: {
                    lastRead: firebase.firestore.Timestamp.now(),
                }
            }
        };
        await firebase.assertFails(chatRef.update(otherUserData));
    });

    it("forbids updating the participants or createdAt fields", async () => {
        const db = getFirestore(myAuth);
        const chatRef = db.collection(Collections.CHATS).doc(chatId);
        let updateData = updateChatData();
        updateData.participantIds = [UID, "newUser"];
        await firebase.assertFails(chatRef.update(updateData));
        let updateDataTime = updateChatData()
        updateDataTime.createdAt = firebase.firestore.Timestamp.now();
        await firebase.assertFails(chatRef.update(updateDataTime));
    });

});
