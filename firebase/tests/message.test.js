const assert = require("assert");
const firebase = require("@firebase/testing");
const { getFirestore, getAdminFirestore, clearFirestoreData } = require('./setup');
const FieldValue = firebase.firestore.FieldValue;
const { Collections } = require('./constants');

const UID = "testUser";
const myAuth = { uid: UID, email: "example@gmail.com" };
const wrongAuth = { uid: "wrongUser", email: "wrong@gmail.com" };
const chatId = "chat1";
const participantIds = [UID, "otherUser"];

function getMessageData() {
    return {
        senderId: UID,
        text: "Hello",
        chatId: chatId,
        createdAt: firebase.firestore.Timestamp.now(),
        lastUpdatedAt: firebase.firestore.Timestamp.now(),
        participantIds: participantIds,
        runtimeType: "default"
    };
}

const db = getFirestore(myAuth);
const wrongDb = getFirestore(wrongAuth);

describe("Messages", () => {
    const adminDb = getAdminFirestore();
    let chatRef;

    beforeEach(async () => {
        await clearFirestoreData();
        chatRef = adminDb.collection(Collections.CHATS).doc(chatId);
        await chatRef.set({
            participantIds: participantIds,
            originalParticipantIds: participantIds,
            createdAt: FieldValue.serverTimestamp(),
            lastUpdatedAt: FieldValue.serverTimestamp(),
            score: 2.5,
        });
        await adminDb.collection(Collections.CHATS).doc(chatId).collection(Collections.MESSAGES).add(getMessageData());
    });
    

    it("can be loaded as a group by participants", async () => {
        const messageRef = db.collectionGroup(Collections.MESSAGES);
        const query = messageRef.where("participantIds", "array-contains", myAuth.uid);
        const messages = await query.get();
        await firebase.assertSucceeds(messages);
        assert.equal(messages.docs.length, 1);

        const query2 = wrongDb
        .collectionGroup(Collections.MESSAGES)
        .where("participantIds", "array-contains", myAuth.uid);
        await firebase.assertFails(query2.get());
    });

    const messageRef = db.collection(Collections.CHATS).doc(chatId).collection(Collections.MESSAGES);
    const wrongMessageRef = wrongDb.collection(Collections.CHATS).doc(chatId).collection(Collections.MESSAGES);

    it("can be loaded per chat by its participants", async () => {
        const messages = await messageRef.get();
        await firebase.assertSucceeds(messages);
        assert.equal(messages.docs.length, 1);

        await firebase.assertFails(wrongMessageRef.get());
    });

    it("can be created by a participant", async () => {
        const messageData = getMessageData();
        await firebase.assertSucceeds(messageRef.add(messageData));
        await firebase.assertFails(wrongMessageRef.add(messageData));
    });

    it("can only have the same participants as the original participants of the chat", async () => {
        const messageData = getMessageData();
        messageData.participantIds = [UID, "wrongUser"];
        await firebase.assertFails(messageRef.add(messageData));
    });

    it("can't send messages if I'm the last participant", async () => {
        await chatRef.update({ participantIds: [UID] });
        const messageData = getMessageData();
        await firebase.assertFails(messageRef.add(messageData));
    });

    it("can send messages after user leaves the chat", async () => {
        const originalParticipantIds = participantIds.concat("yetAnotherUser");
        const messageData = getMessageData();
        messageData.participantIds = originalParticipantIds;
        await firebase.assertFails(messageRef.add(messageData));
        await chatRef.update({ participantIds: participantIds, originalParticipantIds: originalParticipantIds });
        await firebase.assertSucceeds(messageRef.add(messageData));
    });

    it("text needs to be a string", async () => {
        const messageData = getMessageData();
        delete messageData.text;
        await firebase.assertFails(messageRef.add(messageData));
        messageData.text = 123;
        await firebase.assertFails(messageRef.add(messageData));
    });

    it("senderId needs to be the authenticated user", async () => {
        const messageData = getMessageData();
        messageData.senderId = "otherUser";
        await firebase.assertFails(messageRef.add(messageData));
    });

    it("createdAt needs to be now or in the past and maximum 7 days old", async () => {
        const messageData = getMessageData();
        messageData.createdAt = "wrong";
        await firebase.assertFails(messageRef.add(messageData));

        const future = new Date();
        future.setSeconds(future.getSeconds() + 10);
        messageData.createdAt = firebase.firestore.Timestamp.fromDate(future);
        await firebase.assertFails(messageRef.add(messageData));

        const tooOld = new Date();
        tooOld.setDate(tooOld.getDate() - 7);
        messageData.createdAt = firebase.firestore.Timestamp.fromDate(tooOld);
        await firebase.assertFails(messageRef.add(messageData));

        const justInTime = new Date();
        justInTime.setDate(justInTime.getDate() - 7);
        justInTime.setSeconds(justInTime.getSeconds() + 10);
        messageData.createdAt = firebase.firestore.Timestamp.fromDate(justInTime);
        await firebase.assertSucceeds(messageRef.add(messageData));

        messageData.createdAt = FieldValue.serverTimestamp();
        messageData.lastUpdatedAt = FieldValue.serverTimestamp();
        await firebase.assertSucceeds(messageRef.add(messageData));
    });

    it("chatId needs to be the same as the parent chat", async () => {
        const messageData = getMessageData();
        messageData.chatId = "wrongChat";
        await firebase.assertFails(messageRef.add(messageData));
        messageData.chatId = 123;
        await firebase.assertFails(messageRef.add(messageData));
    });

    it("runtimeType needs to be default", async () => {
        const messageData = getMessageData();
        messageData.runtimeType = "wrong";
        await firebase.assertFails(messageRef.add(messageData));
    });

    it("can't be created without chat", async () => {
        const nonExistingChatId = "nonExistingChat";
        const messageData = getMessageData();
        messageData.chatId = nonExistingChatId;
        await firebase.assertFails(db.collection(Collections.CHATS).doc(nonExistingChatId).collection(Collections.MESSAGES).add(messageData));
    });

    it("can't contain other fields", async () => {
        const messageData = getMessageData();
        messageData.wrongField = "wrong";
        await firebase.assertFails(messageRef.add(messageData));
    });

});
