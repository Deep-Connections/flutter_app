const firebase = require("@firebase/testing");

const MY_PROJECT_ID = "deep-connections-7796d";

function getFirestore(auth) {
    return firebase.initializeTestApp({ projectId: MY_PROJECT_ID, auth: auth }).firestore();
}

async function clearFirestoreData() {
    await firebase.clearFirestoreData({ projectId: MY_PROJECT_ID });
}

module.exports = {
    getFirestore,
    clearFirestoreData,
    MY_PROJECT_ID
};
