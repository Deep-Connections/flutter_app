
exit 1
firebase emulators:start --import=./firebase/emulator_storage --export-on-exit

npm test

npm run lint -- --fix

firebase deploy --only functions

firebase firestore:indexes > firestore.indexes.json
