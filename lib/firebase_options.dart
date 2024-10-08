// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyATjX4V43F2IaBHtei4rD9TaOl0xVBZuQk',
    appId: '1:950778574468:web:043525c4074c454ac1b4d1',
    messagingSenderId: '950778574468',
    projectId: 'deep-connections-7796d',
    authDomain: 'deep-connections-7796d.firebaseapp.com',
    storageBucket: 'deep-connections-7796d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAftaBl3sZN27ijh-73j6uOBbKclI5NODI',
    appId: '1:950778574468:android:22d5f6b3a710c36ac1b4d1',
    messagingSenderId: '950778574468',
    projectId: 'deep-connections-7796d',
    storageBucket: 'deep-connections-7796d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBI1lF6mEjlwC13ixaEPExSPY3MWQqI_1o',
    appId: '1:950778574468:ios:680277e84a0849bdc1b4d1',
    messagingSenderId: '950778574468',
    projectId: 'deep-connections-7796d',
    storageBucket: 'deep-connections-7796d.appspot.com',
    iosBundleId: 'com.example.deepConnections',
  );
}
