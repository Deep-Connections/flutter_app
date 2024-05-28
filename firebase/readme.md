# How to use the Firebase emulator

## Install Firebase CLI

### Using Node Package Manager

```sh
npm install -g firebase-tools
```

### Using Homebrew (on MacOS)

```sh
brew install firebase-cli
```

## Run the emulator

### Start the emulator persistently

In this case the emulator will persist the data in the ./firebase/emulator_storage directory.
It will import the data on start and export it on exit.

```sh
firebase emulators:start --import=./firebase/emulator_storage --export-on-exit
```

### Start the emulator without persistence

This way you only import the previous data but don't store it.

```sh
firebase emulators:start --import=./firebase/emulator_storage
```

#### You can export it manually

```sh
firebase emulators:export firebase/emulator_storage
```

## Run tests

Running the tests requires the emulator to be running.

### Run firestore tests

Go to the firebase directory and install the dependencies

```sh
cd firebase
npm install
```

Run the tests

```sh
npm test
```

### Run javascript functions tests

Go to the functions/javascript directory and install the dependencies

```sh
cd functions/javascript
npm install
```

Run the tests

```sh
npm test
```

#### Linting for the functions

```sh
npm run lintFix
```

#### Debug the functions

Run the emulator with the inspect flag

```sh
firebase emulators:start --import=./firebase/emulator_storage --inspect-functions
```

Add a breakpoint in the code

```javascript
debugger;
```

Open chrome and go to chrome://inspect

Then call the functions from the app.

## Deploy

Requires to be logged in to firebase

```sh
firebase login
```

### Deploy the functions

#### Deploy all functions

```sh
firebase deploy --only functions
```

#### Deploy only the javascript functions

```sh
firebase deploy --only functions:javascript-functions
```

#### Deploy only the python functions

```sh
firebase deploy --only functions:python-functions
```

### Deploy firestore

#### Deploy the rules

```sh
firebase deploy --only firestore:rules
```

#### Deploy the indexes

Download the current indexes from the cloud

```sh
firebase firestore:indexes > firestore.indexes.json
```

Deploy the indexes

```sh
firebase firestore:indexes
```

