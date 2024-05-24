
const admin = require("firebase-admin");
const projectId = "deep-connections-7796d";
process.env.GCLOUD_PROJECT = "deep-connections-7796d";
process.env.FIRESTORE_EMULATOR_HOST = "localhost:8080";
admin.initializeApp({ projectId });
const { storeProfiles } = require("./mock/mockProfile");

storeProfiles(10, []).then(() => {
  console.log("Profiles created");
}).catch((e) => {
  console.error(e);
});

// node tests/generateProfiles.js
