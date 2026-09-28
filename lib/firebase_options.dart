// File generated for ExpenseTracker Firebase configuration.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCrvQa57fNVq-YPalq3wCny_OyDFbAANjk',
    appId: '1:25076301550:web:edcb2ed0e8fd2791e67dff',
    messagingSenderId: '25076301550',
    projectId: 'expense-tracker-f565f',
    authDomain: 'expense-tracker-f565f.firebaseapp.com',
    storageBucket: 'expense-tracker-f565f.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrvQa57fNVq-YPalq3wCny_OyDFbAANjk',
    appId: '1:25076301550:android:edcb2ed0e8fd2791e67dff',
    messagingSenderId: '25076301550',
    projectId: 'expense-tracker-f565f',
    storageBucket: 'expense-tracker-f565f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrvQa57fNVq-YPalq3wCny_OyDFbAANjk',
    appId: '1:25076301550:ios:edcb2ed0e8fd2791e67dff',
    messagingSenderId: '25076301550',
    projectId: 'expense-tracker-f565f',
    storageBucket: 'expense-tracker-f565f.firebasestorage.app',
    iosBundleId: 'com.example.expensetracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCrvQa57fNVq-YPalq3wCny_OyDFbAANjk',
    appId: '1:25076301550:ios:edcb2ed0e8fd2791e67dff',
    messagingSenderId: '25076301550',
    projectId: 'expense-tracker-f565f',
    storageBucket: 'expense-tracker-f565f.firebasestorage.app',
    iosBundleId: 'com.example.expensetracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCrvQa57fNVq-YPalq3wCny_OyDFbAANjk',
    appId: '1:25076301550:web:edcb2ed0e8fd2791e67dff',
    messagingSenderId: '25076301550',
    projectId: 'expense-tracker-f565f',
    authDomain: 'expense-tracker-f565f.firebaseapp.com',
    storageBucket: 'expense-tracker-f565f.firebasestorage.app',
  );
}
