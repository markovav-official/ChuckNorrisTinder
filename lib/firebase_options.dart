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
    apiKey: 'AIzaSyCzFXPPyuYBa6yCJT6YH8jXa7c8mBRB5k4',
    appId: '1:39251406215:web:4474152f4c701352e37722',
    messagingSenderId: '39251406215',
    projectId: 'chucknorristinder-ca2b3',
    authDomain: 'chucknorristinder-ca2b3.firebaseapp.com',
    storageBucket: 'chucknorristinder-ca2b3.appspot.com',
    measurementId: 'G-EGNT3SG6V5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIdMSoy8a6-bQoNpGhh9j2AHWKMFjeTp0',
    appId: '1:39251406215:android:7c052a572e6806d1e37722',
    messagingSenderId: '39251406215',
    projectId: 'chucknorristinder-ca2b3',
    storageBucket: 'chucknorristinder-ca2b3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAARAUFSQtuTbxpSVdqVzNoJooMMRfpsYY',
    appId: '1:39251406215:ios:093e977d4cc27ce8e37722',
    messagingSenderId: '39251406215',
    projectId: 'chucknorristinder-ca2b3',
    storageBucket: 'chucknorristinder-ca2b3.appspot.com',
    iosClientId:
        '39251406215-p1ldobjl2usefu771350gckugcptjnll.apps.googleusercontent.com',
    iosBundleId: 'ru.markovav.chuckNorrisTinder',
  );
}
