# Setup Firebase Cloud Functions with Python

This guide will help you set up Firebase Cloud Functions with Python.

## Install Firebase CLI

### Using Node Package Manager
```sh
npm install -g firebase-tools
```

### Using Homebrew (on MacOS)
```sh
brew install firebase-cli
```

## Setup Firebase Cloud Functions

### Navigate to Functions Directory
```sh
cd functions/python
```

### Create and Activate Virtual Environment for Firebase Emulator Suite
```sh
python3 -m venv venv
source venv/bin/activate
```

### Install Requirements
```sh
pip install -r requirements.txt
```

### Deactivate Virtual Environment
```sh
deactivate
```

### Navigate to Root Directory
```sh
cd ../..
```

### Create and Activate Virtual Environment for Development
```sh
python3 -m venv .venv
source .venv/bin/activate
```

### Install Development Requirements
```sh
pip install -r functions/python/dev-requirements.txt
```

### Configure VSCode to Use Virtual Environment
1. Open VSCode.
2. Press `Cmd + Shift + P` to open the Command Palette.
3. Type `Python: Select Interpreter` and within the `.venv` environment you created select the `bin/python`.

## Run the Project

### Run Firebase Emulator 
Run this in a different shell and leave it open while coding. 
```sh
firebase emulators:start --import=./firebase/emulator_storage --export-on-exit
```

### Run Unit Tests
The tests require the Firebase Emulator already setup and running.
```sh
cd functions/python
python -m unittest discover
```