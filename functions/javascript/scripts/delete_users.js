
const admin = require("firebase-admin");

const serviceAccount = require("../../../serviceAccountKey.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  storageBucket: "deep-connections-7796d.appspot.com",
});

const { deleteAccountByUserId } = require("../src/cloud_functions/deleteAccount");

const userIdsToBeDeleted = ["c4TnaWuDjXWkHqIgLvclnjnOlcu1"];

userIdsToBeDeleted.forEach(async (userId) => {
  try {
    await deleteAccountByUserId(userId);
  } catch (error) {
    console.error(`Failed to delete user with id: ${userId}. Error: ${error}`);
  }
});

// node scripts/delete_users.js

