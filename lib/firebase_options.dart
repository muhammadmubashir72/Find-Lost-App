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
        return macos;
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
    apiKey: 'AIzaSyAzRCMla4wmmfi3e3tIkc1PCAvoT3q1faA',
    appId: '1:1062453414820:web:4226ef42ab4607eaf20f31',
    messagingSenderId: '1062453414820',
    projectId: 'find-lost-app',
    authDomain: 'find-lost-app.firebaseapp.com',
    storageBucket: 'find-lost-app.appspot.com',
    measurementId: 'G-SZPX2XX92B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvEHy393C6AW_1TSi2SMaaZBwuQvx-Zrc',
    appId: '1:1062453414820:android:16d7ce4b4212fc1df20f31',
    messagingSenderId: '1062453414820',
    projectId: 'find-lost-app',
    storageBucket: 'find-lost-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD11R6iVaYdXAPOq69-xqzJV_mrRz88RgI',
    appId: '1:1062453414820:ios:0c50c2741bf94cacf20f31',
    messagingSenderId: '1062453414820',
    projectId: 'find-lost-app',
    storageBucket: 'find-lost-app.appspot.com',
    iosBundleId: 'com.example.findlostapp.findLostApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD11R6iVaYdXAPOq69-xqzJV_mrRz88RgI',
    appId: '1:1062453414820:ios:0c50c2741bf94cacf20f31',
    messagingSenderId: '1062453414820',
    projectId: 'find-lost-app',
    storageBucket: 'find-lost-app.appspot.com',
    iosBundleId: 'com.example.findlostapp.findLostApp',
  );
}