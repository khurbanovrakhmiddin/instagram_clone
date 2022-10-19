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
    apiKey: 'AIzaSyAiOx3Nnc0_YmYDRjEaOn7WYucr1Br3sR4',
    appId: '1:1058281653296:web:23745625946b66c12c99f5',
    messagingSenderId: '1058281653296',
    projectId: 'instagram-9846d',
    authDomain: 'instagram-9846d.firebaseapp.com',
    storageBucket: 'instagram-9846d.appspot.com',
    measurementId: 'G-EZRJBHKNHK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxlZ6_MYiKlSc5_UAqN1GxnW9eRY-nKKE',
    appId: '1:1058281653296:android:49eb678011a7496a2c99f5',
    messagingSenderId: '1058281653296',
    projectId: 'instagram-9846d',
    storageBucket: 'instagram-9846d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzfabK0b6nMiE1tMBidDtKduBljwFPeBg',
    appId: '1:1058281653296:ios:6a902ba84810ad812c99f5',
    messagingSenderId: '1058281653296',
    projectId: 'instagram-9846d',
    storageBucket: 'instagram-9846d.appspot.com',
    iosClientId: '1058281653296-6mbkoo9egfvb4ic3a465fi92ep5inuqo.apps.googleusercontent.com',
    iosBundleId: 'com.mobile.bro.instagramClone',
  );
}