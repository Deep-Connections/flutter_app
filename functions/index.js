

const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.createInitialMatch = functions.https.onCall(async (data, context) => {
    if (!context.auth || !context.auth.uid) {
        throw new functions.https.HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }

    const userId = context.auth.uid;


    const profileRef = admin.firestore().collection('profiles').doc(userId);
    const profileSnapshot = await profileRef.get();
    const profileData = profileSnapshot.data();

    if (!profileData) {
        throw new functions.https.HttpsError('not-found', 'Profile not found');
    }

    if (profileData.numMatches >= 1) {
        throw new functions.https.HttpsError('failed-precondition', 'Match already exists');
    }

    const profiles = await admin.firestore().collection('profiles').limit(1).get();
    if (profiles.empty) {
        throw new functions.https.HttpsError('not-found', 'No profiles found');
    }

    const otherUserId = profiles.docs[0].id;
    const match = {
        participantIds: [userId, otherUserId],
        createdAt: admin.firestore.FieldValue.serverTimestamp()
    };

    await admin.firestore().collection('chats').add(match);
    await profileRef.update({ numMatches: admin.firestore.FieldValue.increment(1) });
    await admin.firestore().collection('profiles').doc(otherUserId).update({ numMatches: admin.firestore.FieldValue.increment(1) });

    return { message: 'Match created' };

});

