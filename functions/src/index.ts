

import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();


export const createInitialMatch = functions.https.onRequest( async (req, res) => {
    debugger;

    const userId = req.query.userId; // Or pass via POST body

    if (!userId || typeof userId !== 'string') {
        res.status(400).send('User ID is required');
        return;
    }

    try {
        const profile = await admin.firestore().collection('profiles').doc(userId).get();
        
        const data = profile.data();


        if (!data) {
            res.status(404).send('Profile not found');
            return;
        }

        if (data.numMatches >= 1) {
            res.status(400).send('Match already exists');
            return;
        }

        // todo find similar profiles
        
        const otherProfile = await admin.firestore().collection('profiles').limit(1).get();

        if (otherProfile.empty) {
            res.status(404).send('No profiles found');
            return;
        }

        const otherUserId = otherProfile.docs[0].id;

        const match = {
            participantIds: [userId, otherUserId],
            createdAt: admin.firestore.FieldValue.serverTimestamp()
        };

        await admin.firestore().collection('chats').add(match);
        await admin.firestore().collection('profiles').doc(userId).update({ numMatches: admin.firestore.FieldValue.increment(1) });
        await admin.firestore().collection('profiles').doc(otherUserId).update({ numMatches: admin.firestore.FieldValue.increment(1) });

        res.status(201).send('Match created');
    } catch (error) {
        console.error(error);
        res.status(500).send('Error creating match');
    }
});

