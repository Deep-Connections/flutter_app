

const admin = require("firebase-admin");
admin.initializeApp();

const { createInitialMatch } = require("./src/cloud_functions/createInitialMatch");
const { unmatch } = require("./src/cloud_functions/unmatch");

exports.createInitialMatch = createInitialMatch;

exports.unmatch = unmatch;
