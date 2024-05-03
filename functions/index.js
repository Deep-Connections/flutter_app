

const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

const ageDifference = 5;

const db = admin.firestore();

async function findPotentialMatches(profileData, userId) {
    const birthdate = profileData.birthdate.toDate();
    const fiveYearsOlder = new Date(birthdate);
    fiveYearsOlder.setFullYear(fiveYearsOlder.getFullYear() + ageDifference);
    const fiveYearsYounger = new Date(birthdate);
    fiveYearsYounger.setFullYear(fiveYearsYounger.getFullYear() - ageDifference);

    return await db.collection('profiles')
        .where("languageCodes", 'array-contains-any', profileData.languageCodes)
        .where("birthdate", '<=', fiveYearsOlder)
        .where("birthdate", '>=', fiveYearsYounger)
        .where(admin.firestore.FieldPath.documentId(), '!=', userId)
        .where("numMatches", '<', 5)
        .orderBy("numMatches", "asc")
        .limit(100).get();
}

exports.createInitialMatch = functions.https.onCall(async (data, context) => {
    if (!context.auth || !context.auth.uid) {
        throw new functions.https.HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }

    const userId = context.auth.uid;


    const profileRef = db.collection('profiles').doc(userId);
    const currentProfile = (await profileRef.get()).data();

    if (!currentProfile) {
        throw new functions.https.HttpsError('not-found', 'Current user\'s profile not found');
    }

    // if (currentProfile.numMatches >= 1) {
    //     throw new functions.https.HttpsError('failed-precondition', 'Match already exists');
    // }

    const profiles = await findPotentialMatches(currentProfile, userId);
    const numMatches = profiles.docs.map((profile) => profile.data().numMatches);
    if (profiles.empty) {
        throw new functions.https.HttpsError('not-found', 'No profiles found');
    }

    const otherUserId = profiles.docs[0].id;
    const match = {
        participantIds: [userId, otherUserId],
        createdAt: admin.firestore.FieldValue.serverTimestamp()
    };

    const matchDocRef = db.collection('matches').doc();
    const matchId = matchDocRef.id;
    await matchDocRef.set(match);
    await profileRef.update({ numMatches: admin.firestore.FieldValue.increment(1) });
    await db.collection('profiles').doc(otherUserId).update({ numMatches: admin.firestore.FieldValue.increment(1) });

    return { message: 'Match created', matchId: matchId };

});

