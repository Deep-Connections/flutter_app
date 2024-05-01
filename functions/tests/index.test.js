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

describe('createInitialMatch', () => {

    beforeEach(async () => {
        firebase.clearFirestoreData({ projectId });
    });

    it('should create a match successfully', async () => {
        await admin.firestore().collection('profiles').doc('test-uid').set({ numMatches: 0 });
        await admin.firestore().collection('profiles').doc('other-user-id').set({ numMatches: 0 });
        const context = {
            auth: {
                uid: 'test-uid',
                token: {}
            }
        };

        try {
            const result = await createInitialMatch({}, context);
            assert.equal(result.message, 'Match created');
        } catch (error) {
            throw new Error(`Function threw an error: ${error.message}`);
        }
    });
});

