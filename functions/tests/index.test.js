// https://timo-santi.medium.com/jest-testing-firebase-functions-with-emulator-suite-409907f31f39

const test = require('firebase-functions-test')();
const assert = require('assert');
const admin = require('firebase-admin');

const projectId = 'deep-connections-7796d';

process.env.GCLOUD_PROJECT = projectId;
process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';
admin.initializeApp({ projectId });

// make sure cloud functions don't reinitialize firebase app
require('sinon').stub(admin, 'initializeApp');

const createInitialMatch = test.wrap(require('../index').createInitialMatch)

const firebase = require('@firebase/testing');
const fs = require('fs');

const UID = 'test-uid';

const context = {
    auth: {
        uid: UID,
        token: {}
    }
};

function convertProfileFirebase(profile, numMatches = undefined, firstName = undefined) {
    const birthDate = new Date(profile.birthdate);
    const asFirebaseDate = admin.firestore.Timestamp.fromDate(birthDate);
    profile.birthdate = asFirebaseDate;
    if (numMatches !== undefined)
        profile.numMatches = numMatches;
    if (firstName !== undefined)
        profile.firstName = firstName;
    return profile;
}

function storeMyProfile() {
    const profileData = JSON.parse(fs.readFileSync('../scripts/generated/single_profile.json', 'utf8'));
    return admin.firestore().collection('profiles').doc(UID).set(convertProfileFirebase(profileData));
}

function storeProfile(numMatches = 0) {
    const profileData = JSON.parse(fs.readFileSync('../scripts/generated/single_profile.json', 'utf8'));
    return admin.firestore().collection('profiles').add(convertProfileFirebase(profileData, numMatches));
}

function storeProfiles(numProfiles = 3, numMatches = 0) {
    const multipleProfilesData = JSON.parse(fs.readFileSync('../scripts/generated/multiple_profile.json', 'utf8')).slice(0, numProfiles);
    return Promise.all(multipleProfilesData.map((profile) => {
        admin.firestore().collection('profiles').add(convertProfileFirebase(profile, numMatches));
    }));
}

async function hasNoMatch() {
    try {
        await createInitialMatch({}, context);
        assert.fail('Should have thrown an error');
    } catch (e) {
        assert.equal(e.message, 'No profiles found');
    }
}

describe('InitialMatch', () => {

    beforeEach(async () => {
        await firebase.clearFirestoreData({ projectId });
    });

    it('can create successfully', async () => {
        await storeMyProfile();
        await storeProfile();

        const result = await createInitialMatch({}, context);
        assert.equal(result.message, 'Match created');
        const match = await admin.firestore().collection('matches').doc(result.matchId).get();
        assert.deepEqual(match.data().participantIds[0], UID);
    });

    it('should not find yourself', async () => {
        await storeMyProfile();
        await hasNoMatch();
    });

    it('should prefer people with less matches', async () => {
        await storeMyProfile();
        await storeProfiles(4, 4);
        const ref = await storeProfile(3);
        const result = await createInitialMatch({}, context);
        const match = await admin.firestore().collection('matches').doc(result.matchId).get();
        assert.deepEqual(match.data().participantIds[1], ref.id);
    });

    it('should not find people that already have 5 matches', async () => {
        await storeMyProfile();
        await storeProfile(numMatches = 5);
        await hasNoMatch();
    });
});

