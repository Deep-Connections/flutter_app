
const admin = require("firebase-admin");
const { Collections } = require("../constants");

const serviceAccount = require("../../serviceAccountKey.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();
describe("Querys", () => {
  it.skip("Should fetch profile", async () => {
    const profiles = await db.collection(Collections.PROFILES)
        .where("numMatches", "<", 5)
        .where("gender", "in", ["MAN", "WOMAN"])
        .where("genderPreferences", "array-contains", "WOMAN")
        // .where("dateOfBirth", "<=", Date(2000, 1, 1))
        // .where("dateOfBirth", ">=", Date(1990, 1, 1))
        .orderBy("numMatches", "asc")
        .limit(1).get();
    console.log(profiles.docs[0].data());
  });
});
