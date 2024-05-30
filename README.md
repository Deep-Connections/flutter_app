# Deep Connections (Smetter)

The Flutter project for the Smetter friendship app.

## Getting Started

### Download and install Flutter

Download flutter and extract it to the ~/development folder.

You can download it here:
https://docs.flutter.dev/get-started/install/macos/desktop?tab=download#install-the-flutter-sdk

#### Add flutter to Path

Open the ~/.zshrc file:

```bash
open ~/.zshrc
```

Add the following line to the end of the file, save and close it:

```bash
export PATH=$HOME/development/flutter/bin:$PATH
```

More info about this step here:
https://docs.flutter.dev/get-started/install/macos/desktop?tab=download#install-the-flutter-sdk

#### Verify the installation

Verify the installation by opening a new terminal and run:

```bash
flutter doctor
```

The command for flutter should exist, but still show some uncompleted tasks.

### Run flutter web on Visual Studio Code (Optional)

This requires Chrome to be installed.

1. Open the project in Visual Studio Code
2. Install the Flutter extensions
3. Go to Run and Debug (cmd + shift + D)
4. Next to the play button, select "Dart & Flutter" and press play.

### Download and install Android Studio

Download Android Studio and install it:
https://developer.android.com/studio

#### Install Android SDK

Open Android Studio and go to Preferences (cmd + ,) -> Languages & Frameworks -> Android SDK ->
Select Android 14 (API Level 34) -> Apply.

#### Install SDK command line tools

Open Android Studio and go to Preferences (cmd + ,) -> Languages & Frameworks -> Android SDK -> SDK
Tools -> Check "Android SDK Command-line Tools" -> Apply.

#### Install Flutter plugin

Open Android Studio and go to Preferences (cmd + ,) -> Plugins -> Search for "Flutter" and "Dart" ->
Install.

#### Accept the Android licenses

Open a terminal and run:

```bash
flutter doctor --android-licenses
```

Accept all the licenses by typing "y" and pressing enter.

### Run the app

1. Open Android Studio
2. Open the device manager: Tools -> Device Manager
3. Create a new virtual device (+) and start it (Play button)
4. Run the app by pressing the run button in Android Studio