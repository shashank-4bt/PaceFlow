import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paceflow/app/router/app_router.dart';
import 'package:paceflow/app/theme/app_theme.dart';
import 'package:paceflow/core/constants/app_constants.dart';
import 'package:paceflow/features/settings/presentation/controllers/settings_controller.dart';

class PaceFlowApp extends ConsumerWidget {
  const PaceFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final settings = ref.watch(settingsControllerProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.flutterThemeMode,
      routerConfig: router,
    );
  }
}
