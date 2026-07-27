import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:paceflow/core/constants/app_constants.dart';
import 'package:paceflow/core/constants/storage_keys.dart';
import 'package:paceflow/features/auth/domain/entities/user_profile.dart';
import 'package:paceflow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:paceflow/features/notifications/domain/notification_scheduler.dart';

class SettingsState {
  const SettingsState({
    this.units = AppConstants.unitsKm,
    this.themeMode = 'system',
    this.dailyReminder = true,
    this.dailyReminderHour = 8,
    this.dailyReminderMinute = 0,
    this.weeklySummary = true,
    this.goalCompleted = true,
    this.milestones = true,
    this.shareStatsPublicly = false,
    this.storePreciseLocation = true,
    this.isLoading = false,
  });

  final String units;
  final String themeMode;
  final bool dailyReminder;
  final int dailyReminderHour;
  final int dailyReminderMinute;
  final bool weeklySummary;
  final bool goalCompleted;
  final bool milestones;
  final bool shareStatsPublicly;
  final bool storePreciseLocation;
  final bool isLoading;

  bool get usesMiles => units == AppConstants.unitsMi;

  ThemeMode get flutterThemeMode => switch (themeMode) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };

  SettingsState copyWith({
    String? units,
    String? themeMode,
    bool? dailyReminder,
    int? dailyReminderHour,
    int? dailyReminderMinute,
    bool? weeklySummary,
    bool? goalCompleted,
    bool? milestones,
    bool? shareStatsPublicly,
    bool? storePreciseLocation,
    bool? isLoading,
  }) {
    return SettingsState(
      units: units ?? this.units,
      themeMode: themeMode ?? this.themeMode,
      dailyReminder: dailyReminder ?? this.dailyReminder,
      dailyReminderHour: dailyReminderHour ?? this.dailyReminderHour,
      dailyReminderMinute: dailyReminderMinute ?? this.dailyReminderMinute,
      weeklySummary: weeklySummary ?? this.weeklySummary,
      goalCompleted: goalCompleted ?? this.goalCompleted,
      milestones: milestones ?? this.milestones,
      shareStatsPublicly: shareStatsPublicly ?? this.shareStatsPublicly,
      storePreciseLocation: storePreciseLocation ?? this.storePreciseLocation,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SettingsController extends Notifier<SettingsState> {
  SharedPreferences? _prefs;

  @override
  SettingsState build() {
    _loadFromProfile();
    ref.listen(authControllerProvider, (_, next) {
      if (next.user != null) _applyProfile(next.user!);
    });
    return const SettingsState();
  }

  Future<void> _loadFromProfile() async {
    _prefs = await SharedPreferences.getInstance();
    final user = ref.read(authControllerProvider).user;
    if (user != null) {
      _applyProfile(user);
    } else {
      final units = _prefs?.getString(StorageKeys.units) ?? AppConstants.unitsKm;
      final theme = _prefs?.getString(StorageKeys.themeMode) ?? 'system';
      state = state.copyWith(units: units, themeMode: theme);
    }
  }

  void _applyProfile(UserProfile profile) {
    state = state.copyWith(
      units: profile.units,
      themeMode: profile.themeMode,
      dailyReminder: profile.dailyReminder,
      dailyReminderHour: profile.dailyReminderHour,
      dailyReminderMinute: profile.dailyReminderMinute,
      weeklySummary: profile.weeklySummary,
      goalCompleted: profile.goalCompleted,
      milestones: profile.milestones,
      shareStatsPublicly: profile.shareStatsPublicly,
      storePreciseLocation: profile.storePreciseLocation,
    );
  }

  Future<void> setUnits(String units) async {
    state = state.copyWith(units: units);
    await _prefs?.setString(StorageKeys.units, units);
    await _syncProfile();
  }

  Future<void> setThemeMode(String mode) async {
    state = state.copyWith(themeMode: mode);
    await _prefs?.setString(StorageKeys.themeMode, mode);
    await _syncProfile();
  }

  Future<void> setDailyReminder({
    required bool enabled,
    int? hour,
    int? minute,
  }) async {
    state = state.copyWith(
      dailyReminder: enabled,
      dailyReminderHour: hour ?? state.dailyReminderHour,
      dailyReminderMinute: minute ?? state.dailyReminderMinute,
    );
    await _prefs?.setBool(StorageKeys.dailyReminderEnabled, enabled);
    if (hour != null) await _prefs?.setInt(StorageKeys.dailyReminderHour, hour);
    if (minute != null) {
      await _prefs?.setInt(StorageKeys.dailyReminderMinute, minute);
    }
    await _syncProfile();
    await ref.read(notificationSchedulerProvider).scheduleDailyReminder(
          enabled: enabled,
          hour: state.dailyReminderHour,
          minute: state.dailyReminderMinute,
        );
  }

  Future<void> setWeeklySummary(bool enabled) async {
    state = state.copyWith(weeklySummary: enabled);
    await _prefs?.setBool(StorageKeys.weeklySummaryEnabled, enabled);
    await _syncProfile();
  }

  Future<void> setGoalCompleted(bool enabled) async {
    state = state.copyWith(goalCompleted: enabled);
    await _prefs?.setBool(StorageKeys.goalNotificationsEnabled, enabled);
    await _syncProfile();
  }

  Future<void> setMilestones(bool enabled) async {
    state = state.copyWith(milestones: enabled);
    await _prefs?.setBool(StorageKeys.milestoneNotificationsEnabled, enabled);
    await _syncProfile();
  }

  Future<void> setShareStatsPublicly(bool enabled) async {
    state = state.copyWith(shareStatsPublicly: enabled);
    await _prefs?.setBool(StorageKeys.shareStatsPublicly, enabled);
    await _syncProfile();
  }

  Future<void> setStorePreciseLocation(bool enabled) async {
    state = state.copyWith(storePreciseLocation: enabled);
    await _prefs?.setBool(StorageKeys.storePreciseLocation, enabled);
    await _syncProfile();
  }

  Future<void> _syncProfile() async {
    final user = ref.read(authControllerProvider).user;
    if (user == null) return;

    final updated = user.copyWith(
      units: state.units,
      themeMode: state.themeMode,
      dailyReminder: state.dailyReminder,
      dailyReminderHour: state.dailyReminderHour,
      dailyReminderMinute: state.dailyReminderMinute,
      weeklySummary: state.weeklySummary,
      goalCompleted: state.goalCompleted,
      milestones: state.milestones,
      shareStatsPublicly: state.shareStatsPublicly,
      storePreciseLocation: state.storePreciseLocation,
    );
    await ref.read(authControllerProvider.notifier).updateProfile(updated);
  }
}

final settingsControllerProvider =
    NotifierProvider<SettingsController, SettingsState>(SettingsController.new);
