// File: lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    } else {
      throw UnsupportedError(
        'DefaultFirebaseOptions are not supported for this platform.',
      );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDzDljTmYAC6Uue5iBsaKKUg-V2iuyd910',
    appId: '1:1074561935073:web:366ef88ce7ba244c6f79a0',
    messagingSenderId: '1074561935073',
    projectId: 'sightonscene-a87ca',
    authDomain: 'sightonscene-a87ca.firebaseapp.com',
    storageBucket: 'sightonscene-a87ca.appspot.com',
    measurementId: 'G-PHD0QKDG0H',
  );
}

