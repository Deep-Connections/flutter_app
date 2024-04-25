const firebase = require("@firebase/testing");

const MY_PROJECT_ID = "deep-connections-7796d";

function getFirestore(auth) {
    return firebase.initializeTestApp({ projectId: MY_PROJECT_ID, auth: auth }).firestore();
}

function getAdminFirestore() {
    return firebase.initializeAdminApp({ projectId: MY_PROJECT_ID }).firestore();
}

async function clearFirestoreData() {
    await firebase.clearFirestoreData({ projectId: MY_PROJECT_ID });
}

module.exports = {
    getFirestore,
    getAdminFirestore,
    clearFirestoreData,
    MY_PROJECT_ID
};
