import 'package:equatable/equatable.dart';

enum AchievementId {
  firstWalk('first_walk'),
  distance10k('distance_10k'),
  distance50k('distance_50k'),
  distance100k('distance_100k'),
  streak7('streak_7'),
  streak30('streak_30'),
  walks10('walks_10'),
  walks50('walks_50'),
  calorie1000('calorie_1000');

  const AchievementId(this.key);
  final String key;

  static AchievementId? fromKey(String key) {
    for (final id in AchievementId.values) {
      if (id.key == key) return id;
    }
    return null;
  }
}

class Achievement extends Equatable {
  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    this.unlockedAt,
  });

  final AchievementId id;
  final String title;
  final String description;
  final String iconName;
  final DateTime? unlockedAt;

  bool get isUnlocked => unlockedAt != null;

  Achievement copyWith({DateTime? unlockedAt}) {
    return Achievement(
      id: id,
      title: title,
      description: description,
      iconName: iconName,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  @override
  List<Object?> get props => [id, title, description, iconName, unlockedAt];
}
