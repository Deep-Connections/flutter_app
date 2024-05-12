const assert = require("assert");
const firebase = require("@firebase/testing");
const { getFirestore, clearFirestoreData, getAdminFirestore } = require('./setup');
const { Collections } = require('./constants');

const UID = "test";
const myAuth = { uid: UID, email: "example@gmail.com" };
const db = getFirestore(myAuth);
const admin = getAdminFirestore();

describe("Coin collection in profile", () => {

    beforeEach(async () => {
        await clearFirestoreData();
        // sometimes create a initial profile
        if (Math.random() > 0.0) {
            await firebase.assertSucceeds(db.collection(Collections.PROFILES).doc(UID).set({ firstName: "John"}));
        }
    });

    async function updateProfile(coins, timestamp = null) {
        if (!timestamp) {
            timestamp = firebase.firestore.FieldValue.serverTimestamp();
        }
        return db.collection(Collections.PROFILES).doc(UID).set({
            coins: firebase.firestore.FieldValue.increment(coins),
            lastCollected: timestamp
        },
            {
                merge: true
            }
        );
    }

    it("allows increasing coins by 1", async () => {
        await firebase.assertSucceeds(updateProfile(1));
    });

    it("forbids increasing coins by more than 1", async () => {
        await firebase.assertFails(updateProfile(2));
    });

    it("forbids increasing coins with different timestamp", async () => {
        await firebase.assertFails(updateProfile(1, firebase.firestore.Timestamp.fromDate(new Date(2020, 1, 1))));
    });

    it("allows collecting coins in 24h intervals", async () => {
        await admin.collection(Collections.PROFILES).doc(UID).set({
            coins: 0,
            lastCollected: firebase.firestore.Timestamp.fromMillis(Date.now() - 23 * 60 * 60 * 1000)
        });
        await firebase.assertFails(updateProfile(1));
        await admin.collection(Collections.PROFILES).doc(UID).set({
            coins: 0,
            lastCollected: firebase.firestore.Timestamp.fromMillis(Date.now() - 24 * 60 * 60 * 1000)
        });
        await firebase.assertSucceeds(updateProfile(1));
        await firebase.assertFails(updateProfile(1));
    });


    it("allows leaving coins unchanged", async () => {
        await firebase.assertSucceeds(updateProfile(1));
        await firebase.assertSucceeds(db.collection(Collections.PROFILES).doc(UID).set({firstName: "Bob"}));
    });


});
