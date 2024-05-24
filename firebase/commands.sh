
exit 1
firebase emulators:start --import=./firebase/emulator_storage --export-on-exit

firebase emulators:export firebase/emulator_storage

npm test

npm run lint -- --fix

firebase deploy --only functions

firebase deploy --only functions:javascript-functions

firebase firestore:indexes > firestore.indexes.json
