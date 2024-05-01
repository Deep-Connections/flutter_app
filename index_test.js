const test = require('firebase-functions-test')({
    //storageBucket: 'deep-connections-7796d.appspot.com',
    projectId: 'deep-connections-7796d',
  }, '../../../serviceAccountKey.json');

const createInitialMatch = require('../index').createInitialMatch;

const wrapped = test.wrap(createInitialMatch);

describe('createInitialMatch', () => {

    it('should return a match object', async () => {
        const data = {
            uid: 'test',
            name: 'test',
            email: 'email',
        }
        const context = {
            auth: {
                uid: 'test'
            }
        }
        const result = await wrapped(data, context);
        expect(result).toHaveProperty('uid');
    });
});

