const assert = require("assert");
const firebase = require("@firebase/testing");
const { getFirestore, getAdminFirestore, clearFirestoreData } = require('./setup');
const Collections = require('./constants');

const UID = "testUser";
const myAuth = { uid: UID, email: "example@gmail.com" };
const wrongAuth = { uid: "wrong", email: "otheruser@gmail.com" };
const chatId = "chat1";
const participantIds = [UID, "otherUser"];
const initialTimestamp = firebase.firestore.Timestamp.now();

function getChatData() {
    return {
        participantIds,
        timestamp: initialTimestamp,
        lastMessage: {
            senderId: UID,
            text: "Initial message",
            chatId: chatId,
            timestamp: initialTimestamp
        },
        chatInfo: {
            testUser: {
                unreadMessages: 0,
            },
            otherUser: {
                unreadMessages: 0,
            }
        }
    };
}


describe("Chat functionality", () => {

    beforeEach(async () => { 
        await clearFirestoreData();
        // Use the admin app to bypass security rules and set up initial data
        const adminDb = getAdminFirestore();
        await adminDb.collection(Collections.CHATS).doc(chatId).set({
            participantIds,
            timestamp: initialTimestamp
        });
    });

    after(clearFirestoreData);

    it("can fetch a list of chats where the user is a participant", async () => {
        const db = getFirestore(myAuth);
        const chatsRef = db.collection(Collections.CHATS);
        const query = chatsRef.where("participantIds", "array-contains", myAuth.uid);
        
        const chatDocs = await query.get();
        await firebase.assertSucceeds(chatDocs);
        assert.equal(chatDocs.docs.length, 1);
    });

    it("forbids access to existing chat where the user is not a participant", async () => {
        const db = getFirestore(wrongAuth);
        const chatsRef = db.collection(Collections.CHATS);
        const query = chatsRef.doc(chatId);
        
        await firebase.assertFails(query.get());
    });

    it("allows updating a chat when the user is a participant and all fields are valid", async () => {
        const db = getFirestore(myAuth);
        const chatRef = db.collection(Collections.CHATS).doc(chatId);
        const updateData = getChatData();

        await firebase.assertSucceeds(chatRef.update(updateData));
    });

    it("forbids updates older than 1min than the previous update", async () => {
        // more than 1min older
        const tooOldTimestamp = new firebase.firestore.Timestamp.fromMillis(initialTimestamp.toMillis() - 60001);
        const db = getFirestore(myAuth);
        const chatRef = db.collection(Collections.CHATS).doc(chatId);
        const updateData = getChatData();
        updateData.timestamp = tooOldTimestamp;

        await firebase.assertFails(chatRef.update(updateData));

        // exactly 1min older
        const exactlyOldTimestamp = new firebase.firestore.Timestamp.fromMillis(initialTimestamp.toMillis() - 60000);
        updateData.timestamp = exactlyOldTimestamp;

        await firebase.assertSucceeds(chatRef.update(updateData));
    });

});
