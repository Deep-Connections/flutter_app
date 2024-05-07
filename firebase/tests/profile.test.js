const assert = require("assert");
const firebase = require("@firebase/testing");
const { getFirestore, clearFirestoreData } = require('./setup'); 
const Collections = require('./constants');

const UID = "test";
const myAuth = { uid: UID, email: "example@gmail.com" };

describe("Profiles collection", () => {

    beforeEach(clearFirestoreData);

    it("should be able to read and write to your own profile", async () => {
        const db = getFirestore(myAuth);
        // Read data from Firestore using Collections constant
        await firebase.assertSucceeds(db.collection(Collections.PROFILES).doc(UID).get());
        // Write data to Firestore
        await firebase.assertSucceeds(db.collection(Collections.PROFILES).doc(UID).set({ firstName: "John" }));
    });

    it("can't write to the profile of a different user", async () => {
        const wrongAuth = { uid: "wrong", email: "example@gmail.com" };
        const db = getFirestore(wrongAuth);
        // Read data from Firestore
        await firebase.assertSucceeds(db.collection(Collections.PROFILES).doc(UID).get());
        // Write data to Firestore
        await firebase.assertFails(db.collection(Collections.PROFILES).doc(UID).set({ firstName: "John" }));
    });

    it("can't list all profiles", async () => {
        const db = getFirestore(myAuth);
        await firebase.assertFails(db.collection(Collections.PROFILES).get());
    });
});
