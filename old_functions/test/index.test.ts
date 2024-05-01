import { expect, describe, it } from '@jest/globals';
import * as firebaseFunctionsTest from 'firebase-functions-test';

// Initialize the firebase-functions-test with configuration and service account
const test = firebaseFunctionsTest({
    // Uncomment the next line if you need to specify a storage bucket
    // storageBucket: 'deep-connections-7796d.appspot.com',
    projectId: 'deep-connections-7796d',
}, '../../../serviceAccountKey.json');

import { addCreatedAt } from '../src/index';

const wrapped = test.wrap(addCreatedAt);

describe('addCreatedAt', () => {
    it('should return a match object', async () => {
        const data = {
            firstName: 'Jari',
        };
        const snap = test.firestore.makeDocumentSnapshot(data, 'profiles/123');

        wrapped(snap, { params: { userID: '123' } });

        const after = await snap.ref.get();
        expect(after.data()).toHaveProperty('createdAt');
    });
});
