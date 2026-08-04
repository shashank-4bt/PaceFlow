import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/user_profile.dart';

/// Firestore DTO for [UserProfile].
class UserProfileModel {
  const UserProfileModel({
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

  factory UserProfileModel.fromEntity(UserProfile entity) {
    return UserProfileModel(
      uid: entity.uid,
      email: entity.email,
      displayName: entity.displayName,
      photoUrl: entity.photoUrl,
      bio: entity.bio,
      weightKg: entity.weightKg,
      heightCm: entity.heightCm,
      units: entity.units,
      themeMode: entity.themeMode,
      shareStatsPublicly: entity.shareStatsPublicly,
      showOnLeaderboards: entity.showOnLeaderboards,
      storePreciseLocation: entity.storePreciseLocation,
      dailyReminder: entity.dailyReminder,
      dailyReminderHour: entity.dailyReminderHour,
      dailyReminderMinute: entity.dailyReminderMinute,
      weeklySummary: entity.weeklySummary,
      goalCompleted: entity.goalCompleted,
      milestones: entity.milestones,
      onboardingCompleted: entity.onboardingCompleted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      lastActiveAt: entity.lastActiveAt,
      isDeleted: entity.isDeleted,
    );
  }

  factory UserProfileModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data() ?? {};
    final privacy = data['privacy'] as Map<String, dynamic>? ?? {};
    final notificationPrefs =
        data['notificationPrefs'] as Map<String, dynamic>? ?? {};

    return UserProfileModel(
      uid: data['uid'] as String? ?? snapshot.id,
      email: data['email'] as String? ?? '',
      displayName: data['displayName'] as String? ?? '',
      photoUrl: data['photoUrl'] as String?,
      bio: data['bio'] as String?,
      weightKg: (data['weightKg'] as num?)?.toDouble() ??
          AppConstants.defaultWeightKg,
      heightCm: (data['heightCm'] as num?)?.toDouble(),
      units: data['units'] as String? ?? AppConstants.unitsKm,
      themeMode: data['themeMode'] as String? ?? 'system',
      shareStatsPublicly: privacy['shareStatsPublicly'] as bool? ?? false,
      showOnLeaderboards: privacy['showOnLeaderboards'] as bool? ?? false,
      storePreciseLocation: privacy['storePreciseLocation'] as bool? ?? true,
      dailyReminder: notificationPrefs['dailyReminder'] as bool? ?? true,
      dailyReminderHour: notificationPrefs['dailyReminderHour'] as int? ?? 8,
      dailyReminderMinute:
          notificationPrefs['dailyReminderMinute'] as int? ?? 0,
      weeklySummary: notificationPrefs['weeklySummary'] as bool? ?? true,
      goalCompleted: notificationPrefs['goalCompleted'] as bool? ?? true,
      milestones: notificationPrefs['milestones'] as bool? ?? true,
      onboardingCompleted: data['onboardingCompleted'] as bool? ?? false,
      createdAt: _timestampToDateTime(data['createdAt']),
      updatedAt: _timestampToDateTime(data['updatedAt']),
      lastActiveAt: _timestampToDateTime(data['lastActiveAt']),
      isDeleted: data['isDeleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toFirestore({bool isCreate = false}) {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'bio': bio,
      'weightKg': weightKg,
      'heightCm': heightCm,
      'units': units,
      'themeMode': themeMode,
      'privacy': {
        'shareStatsPublicly': shareStatsPublicly,
        'showOnLeaderboards': showOnLeaderboards,
        'storePreciseLocation': storePreciseLocation,
      },
      'notificationPrefs': {
        'dailyReminder': dailyReminder,
        'dailyReminderHour': dailyReminderHour,
        'dailyReminderMinute': dailyReminderMinute,
        'weeklySummary': weeklySummary,
        'goalCompleted': goalCompleted,
        'milestones': milestones,
      },
      'onboardingCompleted': onboardingCompleted,
      'isDeleted': isDeleted,
      if (isCreate) 'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'lastActiveAt': FieldValue.serverTimestamp(),
    };
  }

  UserProfile toEntity() {
    return UserProfile(
      uid: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      bio: bio,
      weightKg: weightKg,
      heightCm: heightCm,
      units: units,
      themeMode: themeMode,
      shareStatsPublicly: shareStatsPublicly,
      showOnLeaderboards: showOnLeaderboards,
      storePreciseLocation: storePreciseLocation,
      dailyReminder: dailyReminder,
      dailyReminderHour: dailyReminderHour,
      dailyReminderMinute: dailyReminderMinute,
      weeklySummary: weeklySummary,
      goalCompleted: goalCompleted,
      milestones: milestones,
      onboardingCompleted: onboardingCompleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastActiveAt: lastActiveAt,
      isDeleted: isDeleted,
    );
  }

  UserProfileModel copyWith({
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
    return UserProfileModel(
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

  static DateTime? _timestampToDateTime(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    }
    if (value is DateTime) {
      return value;
    }
    return null;
  }
}
