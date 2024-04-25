const assert = require("assert");
const firebase = require("@firebase/testing");


const MY_PROJECT_ID = "deep-connections-7796d";

const PROFILES = "profiles";
const UID = "test";

function getFirestore(auth) {
    return firebase.initializeTestApp({ projectId: MY_PROJECT_ID, auth: auth }).firestore();
}

const myAuth = { uid: UID, email: "example@gmail.com" };


describe("My app", () => {


    it("should be able to read and write to your own profile", async () => {
        const db = firebase.initializeTestApp({ projectId: MY_PROJECT_ID, auth: myAuth }).firestore();
        // Read data from Firestore
        await firebase.assertSucceeds(db.collection(PROFILES).doc(UID).get());
        // Write data to Firestore
        await firebase.assertSucceeds(db.collection(PROFILES).doc(UID).set({ firstName: "John" }));

    });

    it("Can't write to the profile of a different user", async () => {
        const wrongAuth = { uid: "wrong", email: "example@gmail.com" };
        const db = getFirestore(wrongAuth);
        // Read data from Firestore
        await firebase.assertSucceeds(db.collection(PROFILES).doc(UID).get());
        // Write data to Firestore
        await firebase.assertFails(db.collection(PROFILES).doc(UID).set({ firstName: "John" }));

    });

    it("Can't list all profiles", async () => {
        const db = getFirestore(myAuth);
        await firebase.assertFails(db.collection(PROFILES).get());
    });

});

async function clearFirestoreData() {
   await firebase.clearFirestoreData({ projectId: MY_PROJECT_ID });
       //await Promise.all(firebase.apps().map(app => app.delete()));
}

beforeEach(clearFirestoreData);
after(clearFirestoreData);