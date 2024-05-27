
const admin = require("firebase-admin");

const projectId = "javascript-functions-test";


if (!admin.apps.length) {
  process.env.GCLOUD_PROJECT = "deep-connections-7796d";
  process.env.FIRESTORE_EMULATOR_HOST = "localhost:8080";
  process.env.FIREBASE_AUTH_EMULATOR_HOST = "localhost:9099";
  process.env.FIREBASE_STORAGE_EMULATOR_HOST = "localhost:9199";


  admin.initializeApp({ projectId: projectId,
    storageBucket: "deep-connections-7796d.appspot.com",
  });
}

module.exports = { projectId };

