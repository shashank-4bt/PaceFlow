import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_constants.dart';

/// Domain entity representing a PaceFlow user profile.
class UserProfile extends Equatable {
  const UserProfile({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.bio,
    this.weightKg = AppConstants.defaultWeightKg,
    this.heightCm,
    this.units = AppConstants.unitsKm,
    this.themeMode = 'system',
    this.shareStatsPublicly = false,
    this.showOnLeaderboards = false,
    this.storePreciseLocation = true,
    this.dailyReminder = true,
    this.dailyReminderHour = 8,
    this.dailyReminderMinute = 0,
    this.weeklySummary = true,
    this.goalCompleted = true,
    this.milestones = true,
    this.onboardingCompleted = false,
    this.createdAt,
    this.updatedAt,
    this.lastActiveAt,
    this.isDeleted = false,
  });

  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final String? bio;
  final double weightKg;
  final double? heightCm;
  final String units;
  final String themeMode;
  final bool shareStatsPublicly;
  final bool showOnLeaderboards;
  final bool storePreciseLocation;
  final bool dailyReminder;
  final int dailyReminderHour;
  final int dailyReminderMinute;
  final bool weeklySummary;
  final bool goalCompleted;
  final bool milestones;
  final bool onboardingCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastActiveAt;
  final bool isDeleted;

  bool get usesMiles => units == AppConstants.unitsMi;

  UserProfile copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    String? bio,
    double? weightKg,
    double? heightCm,
    String? units,
    String? themeMode,
    bool? shareStatsPublicly,
    bool? showOnLeaderboards,
    bool? storePreciseLocation,
    bool? dailyReminder,
    int? dailyReminderHour,
    int? dailyReminderMinute,
    bool? weeklySummary,
    bool? goalCompleted,
    bool? milestones,
    bool? onboardingCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
    bool? isDeleted,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      weightKg: weightKg ?? this.weightKg,
      heightCm: heightCm ?? this.heightCm,
      units: units ?? this.units,
      themeMode: themeMode ?? this.themeMode,
      shareStatsPublicly: shareStatsPublicly ?? this.shareStatsPublicly,
      showOnLeaderboards: showOnLeaderboards ?? this.showOnLeaderboards,
      storePreciseLocation: storePreciseLocation ?? this.storePreciseLocation,
      dailyReminder: dailyReminder ?? this.dailyReminder,
      dailyReminderHour: dailyReminderHour ?? this.dailyReminderHour,
      dailyReminderMinute: dailyReminderMinute ?? this.dailyReminderMinute,
      weeklySummary: weeklySummary ?? this.weeklySummary,
      goalCompleted: goalCompleted ?? this.goalCompleted,
      milestones: milestones ?? this.milestones,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        displayName,
        photoUrl,
        bio,
        weightKg,
        heightCm,
        units,
        themeMode,
        shareStatsPublicly,
        showOnLeaderboards,
        storePreciseLocation,
        dailyReminder,
        dailyReminderHour,
        dailyReminderMinute,
        weeklySummary,
        goalCompleted,
        milestones,
        onboardingCompleted,
        createdAt,
        updatedAt,
        lastActiveAt,
        isDeleted,
      ];
}
