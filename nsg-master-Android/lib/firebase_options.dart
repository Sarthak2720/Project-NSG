// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyCAgbGKg3rJJe7vQfZse450bKi4YpDlXDY',
    appId: '1:172197093477:web:bc5be22cba0f32b2b9a68c',
    messagingSenderId: '172197093477',
    projectId: 'nsd-project-b4c21',
    authDomain: 'nsd-project-b4c21.firebaseapp.com',
    databaseURL: 'https://nsd-project-b4c21-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'nsd-project-b4c21.appspot.com',
    measurementId: 'G-YFZ1MXJFKM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJ-9KVB694C3r019EICX7yD-fw39_irHA',
    appId: '1:172197093477:android:6ea73d5b8a686c01b9a68c',
    messagingSenderId: '172197093477',
    projectId: 'nsd-project-b4c21',
    databaseURL: 'https://nsd-project-b4c21-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'nsd-project-b4c21.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOrZzGj3buOSCynVeu5UiaV9-92gGvPNo',
    appId: '1:172197093477:ios:7d0739df8fec8940b9a68c',
    messagingSenderId: '172197093477',
    projectId: 'nsd-project-b4c21',
    databaseURL: 'https://nsd-project-b4c21-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'nsd-project-b4c21.appspot.com',
    iosBundleId: 'com.example.nsg',
  );
}
