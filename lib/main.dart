import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paceflow/app/app.dart';
import 'package:paceflow/core/di/providers.dart';
import 'package:paceflow/core/logging/app_logger.dart';
import 'package:paceflow/features/notifications/data/notification_service.dart';
import 'package:paceflow/features/tracking/data/services/background_tracking_service.dart';
import 'package:paceflow/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final logger = AppLogger('main');
  var firebaseReady = false;

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseReady = true;
  } catch (error, stack) {
    logger.error(
      'Firebase initialization failed. Configure dart-defines / google-services.json.',
      error,
      stack,
    );
  }

  if (firebaseReady) {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  final container = ProviderContainer();

  try {
    if (firebaseReady) {
      await container.read(crashReportingServiceProvider).initialize();
    }
    await BackgroundTrackingService.instance.initialize();
    if (firebaseReady) {
      await container.read(notificationServiceProvider).initialize();
    }
  } catch (error, stack) {
    logger.error('Startup initialization failed', error, stack);
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const PaceFlowApp(),
    ),
  );
}
