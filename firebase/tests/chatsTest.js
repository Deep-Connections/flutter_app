const assert = require("assert");
const firebase = require("@firebase/testing");
const { getFirestore, getAdminFirestore, clearFirestoreData } = require('./setup');
const Collections = require('./constants');

const UID = "testUser";
const myAuth = { uid: UID, email: "example@gmail.com" };
const wrongAuth = { uid: "wrong", email: "otheruser@gmail.com" };
const chatId = "chat1";
const participantIds = [UID, "otherUser"];

describe("Chat functionality", () => {

    beforeEach(async () => {
        await clearFirestoreData();
        // Use the admin app to bypass security rules and set up initial data
        const adminDb = getAdminFirestore();
        await adminDb.collection(Collections.CHATS).doc(chatId).set({ participantIds });
    });

    afterEach(clearFirestoreData);

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

});
