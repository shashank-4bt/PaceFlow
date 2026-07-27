import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/core/utils/formatters.dart';
import 'package:paceflow/features/statistics/domain/entities/personal_record.dart';

class RecordsList extends StatelessWidget {
  const RecordsList({
    super.key,
    required this.records,
    required this.useMiles,
  });

  final List<PersonalRecord> records;
  final bool useMiles;

  String _label(PersonalRecordType type) {
    switch (type) {
      case PersonalRecordType.longestDistance:
        return 'Longest Distance';
      case PersonalRecordType.longestDuration:
        return 'Longest Duration';
      case PersonalRecordType.fastestPace:
        return 'Fastest Pace';
      case PersonalRecordType.mostCalories:
        return 'Most Calories';
      case PersonalRecordType.mostSteps:
        return 'Most Steps';
    }
  }

  String _value(PersonalRecord record) {
    switch (record.type) {
      case PersonalRecordType.longestDistance:
        return Formatters.distanceMeters(record.value, useMiles: useMiles);
      case PersonalRecordType.longestDuration:
        return Formatters.durationMs(record.value.toInt());
      case PersonalRecordType.fastestPace:
        return Formatters.paceSecPerUnit(record.value, useMiles: useMiles);
      case PersonalRecordType.mostCalories:
        return Formatters.calories(record.value);
      case PersonalRecordType.mostSteps:
        return Formatters.steps(record.value.toInt());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (records.isEmpty) {
      return Text(
        'Complete walks to set personal records.',
        style: theme.textTheme.bodySmall,
      );
    }

    return Column(
      children: records.map((record) {
        return Card(
          margin: const EdgeInsets.only(bottom: AppSpacings.sm),
          child: ListTile(
            title: Text(_label(record.type)),
            subtitle: Text(Formatters.dateShort(record.achievedAt)),
            trailing: Text(
              _value(record),
              style: theme.textTheme.titleSmall,
            ),
            onTap: () => context.push('/walk/${record.walkId}'),
          ),
        );
      }).toList(),
    );
  }
}
