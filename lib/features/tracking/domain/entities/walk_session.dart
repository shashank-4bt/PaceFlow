import 'package:equatable/equatable.dart';

import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';
import 'package:paceflow/features/tracking/domain/entities/walk_metrics.dart';

enum WalkSessionStatus {
  idle,
  starting,
  active,
  paused,
  stopping,
  completed,
}

enum WalkDbStatus {
  inProgress('in_progress'),
  paused('paused'),
  completed('completed'),
  discarded('discarded');

  const WalkDbStatus(this.value);
  final String value;

  static WalkDbStatus fromValue(String value) {
    return WalkDbStatus.values.firstWhere(
      (s) => s.value == value,
      orElse: () => WalkDbStatus.inProgress,
    );
  }
}

class WalkSession extends Equatable {
  const WalkSession({
    required this.id,
    required this.userId,
    required this.status,
    required this.startedAt,
    this.remoteId,
    this.title,
    this.endedAt,
    this.metrics = WalkMetrics.empty,
    this.points = const [],
    this.pausedAt,
    this.weightKg = 70,
  });

  final String id;
  final String? remoteId;
  final String userId;
  final String? title;
  final WalkSessionStatus status;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime? pausedAt;
  final WalkMetrics metrics;
  final List<GeoPoint> points;
  final double weightKg;

  bool get isActive =>
      status == WalkSessionStatus.active || status == WalkSessionStatus.starting;

  bool get isPaused => status == WalkSessionStatus.paused;

  bool get isTracking =>
      status == WalkSessionStatus.active ||
      status == WalkSessionStatus.starting ||
      status == WalkSessionStatus.paused;

  WalkSession copyWith({
    String? id,
    String? remoteId,
    String? userId,
    String? title,
    WalkSessionStatus? status,
    DateTime? startedAt,
    DateTime? endedAt,
    DateTime? pausedAt,
    WalkMetrics? metrics,
    List<GeoPoint>? points,
    double? weightKg,
    bool clearPausedAt = false,
    bool clearEndedAt = false,
    bool clearRemoteId = false,
    bool clearTitle = false,
  }) {
    return WalkSession(
      id: id ?? this.id,
      remoteId: clearRemoteId ? null : (remoteId ?? this.remoteId),
      userId: userId ?? this.userId,
      title: clearTitle ? null : (title ?? this.title),
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      endedAt: clearEndedAt ? null : (endedAt ?? this.endedAt),
      pausedAt: clearPausedAt ? null : (pausedAt ?? this.pausedAt),
      metrics: metrics ?? this.metrics,
      points: points ?? this.points,
      weightKg: weightKg ?? this.weightKg,
    );
  }

  @override
  List<Object?> get props => [
        id,
        remoteId,
        userId,
        title,
        status,
        startedAt,
        endedAt,
        pausedAt,
        metrics,
        points,
        weightKg,
      ];
}
