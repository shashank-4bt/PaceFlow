// Firebase configuration loaded from compile-time environment variables.
//
// Pass values via `--dart-define` when building or running:
//
//   flutter run \
//     --dart-define=FIREBASE_ANDROID_API_KEY=your_api_key \
//     --dart-define=FIREBASE_ANDROID_APP_ID=1:123456789:android:abc123 \
//     --dart-define=FIREBASE_MESSAGING_SENDER_ID=123456789 \
//     --dart-define=FIREBASE_PROJECT_ID=paceflow-prod \
//     --dart-define=FIREBASE_STORAGE_BUCKET=paceflow-prod.appspot.com
//
// Optional iOS keys (for future iOS support):
//   FIREBASE_IOS_API_KEY, FIREBASE_IOS_APP_ID, FIREBASE_IOS_BUNDLE_ID
//
// Generate production values with: `flutterfire configure`

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

/// Default [FirebaseOptions] for PaceFlow, matching FlutterFire structure.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: String.fromEnvironment(
      'FIREBASE_ANDROID_API_KEY',
      defaultValue: 'AIzaSyDev_PaceFlow_Android_Key_Placeholder',
    ),
    appId: String.fromEnvironment(
      'FIREBASE_ANDROID_APP_ID',
      defaultValue: '1:000000000000:android:0000000000000000000000',
    ),
    messagingSenderId: String.fromEnvironment(
      'FIREBASE_MESSAGING_SENDER_ID',
      defaultValue: '000000000000',
    ),
    projectId: String.fromEnvironment(
      'FIREBASE_PROJECT_ID',
      defaultValue: 'paceflow-dev',
    ),
    storageBucket: String.fromEnvironment(
      'FIREBASE_STORAGE_BUCKET',
      defaultValue: 'paceflow-dev.appspot.com',
    ),
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: String.fromEnvironment(
      'FIREBASE_IOS_API_KEY',
      defaultValue: 'AIzaSyDev_PaceFlow_iOS_Key_Placeholder',
    ),
    appId: String.fromEnvironment(
      'FIREBASE_IOS_APP_ID',
      defaultValue: '1:000000000000:ios:0000000000000000000000',
    ),
    messagingSenderId: String.fromEnvironment(
      'FIREBASE_MESSAGING_SENDER_ID',
      defaultValue: '000000000000',
    ),
    projectId: String.fromEnvironment(
      'FIREBASE_PROJECT_ID',
      defaultValue: 'paceflow-dev',
    ),
    storageBucket: String.fromEnvironment(
      'FIREBASE_STORAGE_BUCKET',
      defaultValue: 'paceflow-dev.appspot.com',
    ),
    iosBundleId: String.fromEnvironment(
      'FIREBASE_IOS_BUNDLE_ID',
      defaultValue: 'com.paceflow.paceflow',
    ),
  );
}
