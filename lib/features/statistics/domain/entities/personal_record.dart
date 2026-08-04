import 'package:equatable/equatable.dart';

enum PersonalRecordType {
  longestDistance,
  longestDuration,
  fastestPace,
  mostCalories,
  mostSteps,
}

class PersonalRecord extends Equatable {
  const PersonalRecord({
    required this.type,
    required this.value,
    required this.walkId,
    required this.achievedAt,
    this.label,
  });

  final PersonalRecordType type;
  final double value;
  final String walkId;
  final DateTime achievedAt;
  final String? label;

  @override
  List<Object?> get props => [type, value, walkId, achievedAt, label];
}
