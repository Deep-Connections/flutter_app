

const admin = require("firebase-admin");
admin.initializeApp();

const { createInitialMatch } = require("./src/cloud_functions/createInitialMatch");
const { unmatch } = require("./src/cloud_functions/unmatch");
const { deleteAccount } = require("./src/cloud_functions/deleteAccount");

exports.createInitialMatch = createInitialMatch;

exports.unmatch = unmatch;

exports.deleteAccount = deleteAccount;
