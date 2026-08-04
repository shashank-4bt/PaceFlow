// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WalksTable extends Walks with TableInfo<$WalksTable, Walk> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<int> startedAt = GeneratedColumn<int>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<int> endedAt = GeneratedColumn<int>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _pausedDurationMsMeta = const VerificationMeta(
    'pausedDurationMs',
  );
  @override
  late final GeneratedColumn<int> pausedDurationMs = GeneratedColumn<int>(
    'paused_duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _distanceMetersMeta = const VerificationMeta(
    'distanceMeters',
  );
  @override
  late final GeneratedColumn<double> distanceMeters = GeneratedColumn<double>(
    'distance_meters',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _avgPaceSecPerKmMeta = const VerificationMeta(
    'avgPaceSecPerKm',
  );
  @override
  late final GeneratedColumn<double> avgPaceSecPerKm = GeneratedColumn<double>(
    'avg_pace_sec_per_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _avgSpeedMpsMeta = const VerificationMeta(
    'avgSpeedMps',
  );
  @override
  late final GeneratedColumn<double> avgSpeedMps = GeneratedColumn<double>(
    'avg_speed_mps',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _maxSpeedMpsMeta = const VerificationMeta(
    'maxSpeedMps',
  );
  @override
  late final GeneratedColumn<double> maxSpeedMps = GeneratedColumn<double>(
    'max_speed_mps',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _caloriesKcalMeta = const VerificationMeta(
    'caloriesKcal',
  );
  @override
  late final GeneratedColumn<double> caloriesKcal = GeneratedColumn<double>(
    'calories_kcal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
    'steps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _elevationGainMMeta = const VerificationMeta(
    'elevationGainM',
  );
  @override
  late final GeneratedColumn<double> elevationGainM = GeneratedColumn<double>(
    'elevation_gain_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _elevationLossMMeta = const VerificationMeta(
    'elevationLossM',
  );
  @override
  late final GeneratedColumn<double> elevationLossM = GeneratedColumn<double>(
    'elevation_loss_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _startLatMeta = const VerificationMeta(
    'startLat',
  );
  @override
  late final GeneratedColumn<double> startLat = GeneratedColumn<double>(
    'start_lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startLngMeta = const VerificationMeta(
    'startLng',
  );
  @override
  late final GeneratedColumn<double> startLng = GeneratedColumn<double>(
    'start_lng',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endLatMeta = const VerificationMeta('endLat');
  @override
  late final GeneratedColumn<double> endLat = GeneratedColumn<double>(
    'end_lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endLngMeta = const VerificationMeta('endLng');
  @override
  late final GeneratedColumn<double> endLng = GeneratedColumn<double>(
    'end_lng',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _boundsJsonMeta = const VerificationMeta(
    'boundsJson',
  );
  @override
  late final GeneratedColumn<String> boundsJson = GeneratedColumn<String>(
    'bounds_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _polylineEncodedMeta = const VerificationMeta(
    'polylineEncoded',
  );
  @override
  late final GeneratedColumn<String> polylineEncoded = GeneratedColumn<String>(
    'polyline_encoded',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pointCountMeta = const VerificationMeta(
    'pointCount',
  );
  @override
  late final GeneratedColumn<int> pointCount = GeneratedColumn<int>(
    'point_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _syncErrorMeta = const VerificationMeta(
    'syncError',
  );
  @override
  late final GeneratedColumn<String> syncError = GeneratedColumn<String>(
    'sync_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncVersionMeta = const VerificationMeta(
    'syncVersion',
  );
  @override
  late final GeneratedColumn<int> syncVersion = GeneratedColumn<int>(
    'sync_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    userId,
    title,
    status,
    startedAt,
    endedAt,
    durationMs,
    pausedDurationMs,
    distanceMeters,
    avgPaceSecPerKm,
    avgSpeedMps,
    maxSpeedMps,
    caloriesKcal,
    steps,
    elevationGainM,
    elevationLossM,
    startLat,
    startLng,
    endLat,
    endLng,
    boundsJson,
    polylineEncoded,
    pointCount,
    syncStatus,
    syncError,
    syncVersion,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'walks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Walk> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    }
    if (data.containsKey('paused_duration_ms')) {
      context.handle(
        _pausedDurationMsMeta,
        pausedDurationMs.isAcceptableOrUnknown(
          data['paused_duration_ms']!,
          _pausedDurationMsMeta,
        ),
      );
    }
    if (data.containsKey('distance_meters')) {
      context.handle(
        _distanceMetersMeta,
        distanceMeters.isAcceptableOrUnknown(
          data['distance_meters']!,
          _distanceMetersMeta,
        ),
      );
    }
    if (data.containsKey('avg_pace_sec_per_km')) {
      context.handle(
        _avgPaceSecPerKmMeta,
        avgPaceSecPerKm.isAcceptableOrUnknown(
          data['avg_pace_sec_per_km']!,
          _avgPaceSecPerKmMeta,
        ),
      );
    }
    if (data.containsKey('avg_speed_mps')) {
      context.handle(
        _avgSpeedMpsMeta,
        avgSpeedMps.isAcceptableOrUnknown(
          data['avg_speed_mps']!,
          _avgSpeedMpsMeta,
        ),
      );
    }
    if (data.containsKey('max_speed_mps')) {
      context.handle(
        _maxSpeedMpsMeta,
        maxSpeedMps.isAcceptableOrUnknown(
          data['max_speed_mps']!,
          _maxSpeedMpsMeta,
        ),
      );
    }
    if (data.containsKey('calories_kcal')) {
      context.handle(
        _caloriesKcalMeta,
        caloriesKcal.isAcceptableOrUnknown(
          data['calories_kcal']!,
          _caloriesKcalMeta,
        ),
      );
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    }
    if (data.containsKey('elevation_gain_m')) {
      context.handle(
        _elevationGainMMeta,
        elevationGainM.isAcceptableOrUnknown(
          data['elevation_gain_m']!,
          _elevationGainMMeta,
        ),
      );
    }
    if (data.containsKey('elevation_loss_m')) {
      context.handle(
        _elevationLossMMeta,
        elevationLossM.isAcceptableOrUnknown(
          data['elevation_loss_m']!,
          _elevationLossMMeta,
        ),
      );
    }
    if (data.containsKey('start_lat')) {
      context.handle(
        _startLatMeta,
        startLat.isAcceptableOrUnknown(data['start_lat']!, _startLatMeta),
      );
    }
    if (data.containsKey('start_lng')) {
      context.handle(
        _startLngMeta,
        startLng.isAcceptableOrUnknown(data['start_lng']!, _startLngMeta),
      );
    }
    if (data.containsKey('end_lat')) {
      context.handle(
        _endLatMeta,
        endLat.isAcceptableOrUnknown(data['end_lat']!, _endLatMeta),
      );
    }
    if (data.containsKey('end_lng')) {
      context.handle(
        _endLngMeta,
        endLng.isAcceptableOrUnknown(data['end_lng']!, _endLngMeta),
      );
    }
    if (data.containsKey('bounds_json')) {
      context.handle(
        _boundsJsonMeta,
        boundsJson.isAcceptableOrUnknown(data['bounds_json']!, _boundsJsonMeta),
      );
    }
    if (data.containsKey('polyline_encoded')) {
      context.handle(
        _polylineEncodedMeta,
        polylineEncoded.isAcceptableOrUnknown(
          data['polyline_encoded']!,
          _polylineEncodedMeta,
        ),
      );
    }
    if (data.containsKey('point_count')) {
      context.handle(
        _pointCountMeta,
        pointCount.isAcceptableOrUnknown(data['point_count']!, _pointCountMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('sync_error')) {
      context.handle(
        _syncErrorMeta,
        syncError.isAcceptableOrUnknown(data['sync_error']!, _syncErrorMeta),
      );
    }
    if (data.containsKey('sync_version')) {
      context.handle(
        _syncVersionMeta,
        syncVersion.isAcceptableOrUnknown(
          data['sync_version']!,
          _syncVersionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Walk map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Walk(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ended_at'],
      ),
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      )!,
      pausedDurationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paused_duration_ms'],
      )!,
      distanceMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_meters'],
      )!,
      avgPaceSecPerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_pace_sec_per_km'],
      )!,
      avgSpeedMps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_speed_mps'],
      )!,
      maxSpeedMps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_speed_mps'],
      )!,
      caloriesKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories_kcal'],
      )!,
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}steps'],
      )!,
      elevationGainM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}elevation_gain_m'],
      )!,
      elevationLossM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}elevation_loss_m'],
      )!,
      startLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}start_lat'],
      ),
      startLng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}start_lng'],
      ),
      endLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}end_lat'],
      ),
      endLng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}end_lng'],
      ),
      boundsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bounds_json'],
      ),
      polylineEncoded: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}polyline_encoded'],
      ),
      pointCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}point_count'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      syncError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_error'],
      ),
      syncVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_version'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WalksTable createAlias(String alias) {
    return $WalksTable(attachedDatabase, alias);
  }
}

class Walk extends DataClass implements Insertable<Walk> {
  final String id;
  final String? remoteId;
  final String userId;
  final String? title;
  final String status;
  final int startedAt;
  final int? endedAt;
  final int durationMs;
  final int pausedDurationMs;
  final double distanceMeters;
  final double avgPaceSecPerKm;
  final double avgSpeedMps;
  final double maxSpeedMps;
  final double caloriesKcal;
  final int steps;
  final double elevationGainM;
  final double elevationLossM;
  final double? startLat;
  final double? startLng;
  final double? endLat;
  final double? endLng;
  final String? boundsJson;
  final String? polylineEncoded;
  final int pointCount;
  final String syncStatus;
  final String? syncError;
  final int syncVersion;
  final int createdAt;
  final int updatedAt;
  const Walk({
    required this.id,
    this.remoteId,
    required this.userId,
    this.title,
    required this.status,
    required this.startedAt,
    this.endedAt,
    required this.durationMs,
    required this.pausedDurationMs,
    required this.distanceMeters,
    required this.avgPaceSecPerKm,
    required this.avgSpeedMps,
    required this.maxSpeedMps,
    required this.caloriesKcal,
    required this.steps,
    required this.elevationGainM,
    required this.elevationLossM,
    this.startLat,
    this.startLng,
    this.endLat,
    this.endLng,
    this.boundsJson,
    this.polylineEncoded,
    required this.pointCount,
    required this.syncStatus,
    this.syncError,
    required this.syncVersion,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['status'] = Variable<String>(status);
    map['started_at'] = Variable<int>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<int>(endedAt);
    }
    map['duration_ms'] = Variable<int>(durationMs);
    map['paused_duration_ms'] = Variable<int>(pausedDurationMs);
    map['distance_meters'] = Variable<double>(distanceMeters);
    map['avg_pace_sec_per_km'] = Variable<double>(avgPaceSecPerKm);
    map['avg_speed_mps'] = Variable<double>(avgSpeedMps);
    map['max_speed_mps'] = Variable<double>(maxSpeedMps);
    map['calories_kcal'] = Variable<double>(caloriesKcal);
    map['steps'] = Variable<int>(steps);
    map['elevation_gain_m'] = Variable<double>(elevationGainM);
    map['elevation_loss_m'] = Variable<double>(elevationLossM);
    if (!nullToAbsent || startLat != null) {
      map['start_lat'] = Variable<double>(startLat);
    }
    if (!nullToAbsent || startLng != null) {
      map['start_lng'] = Variable<double>(startLng);
    }
    if (!nullToAbsent || endLat != null) {
      map['end_lat'] = Variable<double>(endLat);
    }
    if (!nullToAbsent || endLng != null) {
      map['end_lng'] = Variable<double>(endLng);
    }
    if (!nullToAbsent || boundsJson != null) {
      map['bounds_json'] = Variable<String>(boundsJson);
    }
    if (!nullToAbsent || polylineEncoded != null) {
      map['polyline_encoded'] = Variable<String>(polylineEncoded);
    }
    map['point_count'] = Variable<int>(pointCount);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || syncError != null) {
      map['sync_error'] = Variable<String>(syncError);
    }
    map['sync_version'] = Variable<int>(syncVersion);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  WalksCompanion toCompanion(bool nullToAbsent) {
    return WalksCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      userId: Value(userId),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      status: Value(status),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      durationMs: Value(durationMs),
      pausedDurationMs: Value(pausedDurationMs),
      distanceMeters: Value(distanceMeters),
      avgPaceSecPerKm: Value(avgPaceSecPerKm),
      avgSpeedMps: Value(avgSpeedMps),
      maxSpeedMps: Value(maxSpeedMps),
      caloriesKcal: Value(caloriesKcal),
      steps: Value(steps),
      elevationGainM: Value(elevationGainM),
      elevationLossM: Value(elevationLossM),
      startLat: startLat == null && nullToAbsent
          ? const Value.absent()
          : Value(startLat),
      startLng: startLng == null && nullToAbsent
          ? const Value.absent()
          : Value(startLng),
      endLat: endLat == null && nullToAbsent
          ? const Value.absent()
          : Value(endLat),
      endLng: endLng == null && nullToAbsent
          ? const Value.absent()
          : Value(endLng),
      boundsJson: boundsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(boundsJson),
      polylineEncoded: polylineEncoded == null && nullToAbsent
          ? const Value.absent()
          : Value(polylineEncoded),
      pointCount: Value(pointCount),
      syncStatus: Value(syncStatus),
      syncError: syncError == null && nullToAbsent
          ? const Value.absent()
          : Value(syncError),
      syncVersion: Value(syncVersion),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Walk.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Walk(
      id: serializer.fromJson<String>(json['id']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      userId: serializer.fromJson<String>(json['userId']),
      title: serializer.fromJson<String?>(json['title']),
      status: serializer.fromJson<String>(json['status']),
      startedAt: serializer.fromJson<int>(json['startedAt']),
      endedAt: serializer.fromJson<int?>(json['endedAt']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
      pausedDurationMs: serializer.fromJson<int>(json['pausedDurationMs']),
      distanceMeters: serializer.fromJson<double>(json['distanceMeters']),
      avgPaceSecPerKm: serializer.fromJson<double>(json['avgPaceSecPerKm']),
      avgSpeedMps: serializer.fromJson<double>(json['avgSpeedMps']),
      maxSpeedMps: serializer.fromJson<double>(json['maxSpeedMps']),
      caloriesKcal: serializer.fromJson<double>(json['caloriesKcal']),
      steps: serializer.fromJson<int>(json['steps']),
      elevationGainM: serializer.fromJson<double>(json['elevationGainM']),
      elevationLossM: serializer.fromJson<double>(json['elevationLossM']),
      startLat: serializer.fromJson<double?>(json['startLat']),
      startLng: serializer.fromJson<double?>(json['startLng']),
      endLat: serializer.fromJson<double?>(json['endLat']),
      endLng: serializer.fromJson<double?>(json['endLng']),
      boundsJson: serializer.fromJson<String?>(json['boundsJson']),
      polylineEncoded: serializer.fromJson<String?>(json['polylineEncoded']),
      pointCount: serializer.fromJson<int>(json['pointCount']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      syncError: serializer.fromJson<String?>(json['syncError']),
      syncVersion: serializer.fromJson<int>(json['syncVersion']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'remoteId': serializer.toJson<String?>(remoteId),
      'userId': serializer.toJson<String>(userId),
      'title': serializer.toJson<String?>(title),
      'status': serializer.toJson<String>(status),
      'startedAt': serializer.toJson<int>(startedAt),
      'endedAt': serializer.toJson<int?>(endedAt),
      'durationMs': serializer.toJson<int>(durationMs),
      'pausedDurationMs': serializer.toJson<int>(pausedDurationMs),
      'distanceMeters': serializer.toJson<double>(distanceMeters),
      'avgPaceSecPerKm': serializer.toJson<double>(avgPaceSecPerKm),
      'avgSpeedMps': serializer.toJson<double>(avgSpeedMps),
      'maxSpeedMps': serializer.toJson<double>(maxSpeedMps),
      'caloriesKcal': serializer.toJson<double>(caloriesKcal),
      'steps': serializer.toJson<int>(steps),
      'elevationGainM': serializer.toJson<double>(elevationGainM),
      'elevationLossM': serializer.toJson<double>(elevationLossM),
      'startLat': serializer.toJson<double?>(startLat),
      'startLng': serializer.toJson<double?>(startLng),
      'endLat': serializer.toJson<double?>(endLat),
      'endLng': serializer.toJson<double?>(endLng),
      'boundsJson': serializer.toJson<String?>(boundsJson),
      'polylineEncoded': serializer.toJson<String?>(polylineEncoded),
      'pointCount': serializer.toJson<int>(pointCount),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'syncError': serializer.toJson<String?>(syncError),
      'syncVersion': serializer.toJson<int>(syncVersion),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  Walk copyWith({
    String? id,
    Value<String?> remoteId = const Value.absent(),
    String? userId,
    Value<String?> title = const Value.absent(),
    String? status,
    int? startedAt,
    Value<int?> endedAt = const Value.absent(),
    int? durationMs,
    int? pausedDurationMs,
    double? distanceMeters,
    double? avgPaceSecPerKm,
    double? avgSpeedMps,
    double? maxSpeedMps,
    double? caloriesKcal,
    int? steps,
    double? elevationGainM,
    double? elevationLossM,
    Value<double?> startLat = const Value.absent(),
    Value<double?> startLng = const Value.absent(),
    Value<double?> endLat = const Value.absent(),
    Value<double?> endLng = const Value.absent(),
    Value<String?> boundsJson = const Value.absent(),
    Value<String?> polylineEncoded = const Value.absent(),
    int? pointCount,
    String? syncStatus,
    Value<String?> syncError = const Value.absent(),
    int? syncVersion,
    int? createdAt,
    int? updatedAt,
  }) => Walk(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    userId: userId ?? this.userId,
    title: title.present ? title.value : this.title,
    status: status ?? this.status,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    durationMs: durationMs ?? this.durationMs,
    pausedDurationMs: pausedDurationMs ?? this.pausedDurationMs,
    distanceMeters: distanceMeters ?? this.distanceMeters,
    avgPaceSecPerKm: avgPaceSecPerKm ?? this.avgPaceSecPerKm,
    avgSpeedMps: avgSpeedMps ?? this.avgSpeedMps,
    maxSpeedMps: maxSpeedMps ?? this.maxSpeedMps,
    caloriesKcal: caloriesKcal ?? this.caloriesKcal,
    steps: steps ?? this.steps,
    elevationGainM: elevationGainM ?? this.elevationGainM,
    elevationLossM: elevationLossM ?? this.elevationLossM,
    startLat: startLat.present ? startLat.value : this.startLat,
    startLng: startLng.present ? startLng.value : this.startLng,
    endLat: endLat.present ? endLat.value : this.endLat,
    endLng: endLng.present ? endLng.value : this.endLng,
    boundsJson: boundsJson.present ? boundsJson.value : this.boundsJson,
    polylineEncoded: polylineEncoded.present
        ? polylineEncoded.value
        : this.polylineEncoded,
    pointCount: pointCount ?? this.pointCount,
    syncStatus: syncStatus ?? this.syncStatus,
    syncError: syncError.present ? syncError.value : this.syncError,
    syncVersion: syncVersion ?? this.syncVersion,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Walk copyWithCompanion(WalksCompanion data) {
    return Walk(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      status: data.status.present ? data.status.value : this.status,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      pausedDurationMs: data.pausedDurationMs.present
          ? data.pausedDurationMs.value
          : this.pausedDurationMs,
      distanceMeters: data.distanceMeters.present
          ? data.distanceMeters.value
          : this.distanceMeters,
      avgPaceSecPerKm: data.avgPaceSecPerKm.present
          ? data.avgPaceSecPerKm.value
          : this.avgPaceSecPerKm,
      avgSpeedMps: data.avgSpeedMps.present
          ? data.avgSpeedMps.value
          : this.avgSpeedMps,
      maxSpeedMps: data.maxSpeedMps.present
          ? data.maxSpeedMps.value
          : this.maxSpeedMps,
      caloriesKcal: data.caloriesKcal.present
          ? data.caloriesKcal.value
          : this.caloriesKcal,
      steps: data.steps.present ? data.steps.value : this.steps,
      elevationGainM: data.elevationGainM.present
          ? data.elevationGainM.value
          : this.elevationGainM,
      elevationLossM: data.elevationLossM.present
          ? data.elevationLossM.value
          : this.elevationLossM,
      startLat: data.startLat.present ? data.startLat.value : this.startLat,
      startLng: data.startLng.present ? data.startLng.value : this.startLng,
      endLat: data.endLat.present ? data.endLat.value : this.endLat,
      endLng: data.endLng.present ? data.endLng.value : this.endLng,
      boundsJson: data.boundsJson.present
          ? data.boundsJson.value
          : this.boundsJson,
      polylineEncoded: data.polylineEncoded.present
          ? data.polylineEncoded.value
          : this.polylineEncoded,
      pointCount: data.pointCount.present
          ? data.pointCount.value
          : this.pointCount,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      syncError: data.syncError.present ? data.syncError.value : this.syncError,
      syncVersion: data.syncVersion.present
          ? data.syncVersion.value
          : this.syncVersion,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Walk(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationMs: $durationMs, ')
          ..write('pausedDurationMs: $pausedDurationMs, ')
          ..write('distanceMeters: $distanceMeters, ')
          ..write('avgPaceSecPerKm: $avgPaceSecPerKm, ')
          ..write('avgSpeedMps: $avgSpeedMps, ')
          ..write('maxSpeedMps: $maxSpeedMps, ')
          ..write('caloriesKcal: $caloriesKcal, ')
          ..write('steps: $steps, ')
          ..write('elevationGainM: $elevationGainM, ')
          ..write('elevationLossM: $elevationLossM, ')
          ..write('startLat: $startLat, ')
          ..write('startLng: $startLng, ')
          ..write('endLat: $endLat, ')
          ..write('endLng: $endLng, ')
          ..write('boundsJson: $boundsJson, ')
          ..write('polylineEncoded: $polylineEncoded, ')
          ..write('pointCount: $pointCount, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncError: $syncError, ')
          ..write('syncVersion: $syncVersion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    remoteId,
    userId,
    title,
    status,
    startedAt,
    endedAt,
    durationMs,
    pausedDurationMs,
    distanceMeters,
    avgPaceSecPerKm,
    avgSpeedMps,
    maxSpeedMps,
    caloriesKcal,
    steps,
    elevationGainM,
    elevationLossM,
    startLat,
    startLng,
    endLat,
    endLng,
    boundsJson,
    polylineEncoded,
    pointCount,
    syncStatus,
    syncError,
    syncVersion,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Walk &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.status == this.status &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.durationMs == this.durationMs &&
          other.pausedDurationMs == this.pausedDurationMs &&
          other.distanceMeters == this.distanceMeters &&
          other.avgPaceSecPerKm == this.avgPaceSecPerKm &&
          other.avgSpeedMps == this.avgSpeedMps &&
          other.maxSpeedMps == this.maxSpeedMps &&
          other.caloriesKcal == this.caloriesKcal &&
          other.steps == this.steps &&
          other.elevationGainM == this.elevationGainM &&
          other.elevationLossM == this.elevationLossM &&
          other.startLat == this.startLat &&
          other.startLng == this.startLng &&
          other.endLat == this.endLat &&
          other.endLng == this.endLng &&
          other.boundsJson == this.boundsJson &&
          other.polylineEncoded == this.polylineEncoded &&
          other.pointCount == this.pointCount &&
          other.syncStatus == this.syncStatus &&
          other.syncError == this.syncError &&
          other.syncVersion == this.syncVersion &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WalksCompanion extends UpdateCompanion<Walk> {
  final Value<String> id;
  final Value<String?> remoteId;
  final Value<String> userId;
  final Value<String?> title;
  final Value<String> status;
  final Value<int> startedAt;
  final Value<int?> endedAt;
  final Value<int> durationMs;
  final Value<int> pausedDurationMs;
  final Value<double> distanceMeters;
  final Value<double> avgPaceSecPerKm;
  final Value<double> avgSpeedMps;
  final Value<double> maxSpeedMps;
  final Value<double> caloriesKcal;
  final Value<int> steps;
  final Value<double> elevationGainM;
  final Value<double> elevationLossM;
  final Value<double?> startLat;
  final Value<double?> startLng;
  final Value<double?> endLat;
  final Value<double?> endLng;
  final Value<String?> boundsJson;
  final Value<String?> polylineEncoded;
  final Value<int> pointCount;
  final Value<String> syncStatus;
  final Value<String?> syncError;
  final Value<int> syncVersion;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const WalksCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.status = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.pausedDurationMs = const Value.absent(),
    this.distanceMeters = const Value.absent(),
    this.avgPaceSecPerKm = const Value.absent(),
    this.avgSpeedMps = const Value.absent(),
    this.maxSpeedMps = const Value.absent(),
    this.caloriesKcal = const Value.absent(),
    this.steps = const Value.absent(),
    this.elevationGainM = const Value.absent(),
    this.elevationLossM = const Value.absent(),
    this.startLat = const Value.absent(),
    this.startLng = const Value.absent(),
    this.endLat = const Value.absent(),
    this.endLng = const Value.absent(),
    this.boundsJson = const Value.absent(),
    this.polylineEncoded = const Value.absent(),
    this.pointCount = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.syncError = const Value.absent(),
    this.syncVersion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WalksCompanion.insert({
    required String id,
    this.remoteId = const Value.absent(),
    required String userId,
    this.title = const Value.absent(),
    required String status,
    required int startedAt,
    this.endedAt = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.pausedDurationMs = const Value.absent(),
    this.distanceMeters = const Value.absent(),
    this.avgPaceSecPerKm = const Value.absent(),
    this.avgSpeedMps = const Value.absent(),
    this.maxSpeedMps = const Value.absent(),
    this.caloriesKcal = const Value.absent(),
    this.steps = const Value.absent(),
    this.elevationGainM = const Value.absent(),
    this.elevationLossM = const Value.absent(),
    this.startLat = const Value.absent(),
    this.startLng = const Value.absent(),
    this.endLat = const Value.absent(),
    this.endLng = const Value.absent(),
    this.boundsJson = const Value.absent(),
    this.polylineEncoded = const Value.absent(),
    this.pointCount = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.syncError = const Value.absent(),
    this.syncVersion = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       status = Value(status),
       startedAt = Value(startedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Walk> custom({
    Expression<String>? id,
    Expression<String>? remoteId,
    Expression<String>? userId,
    Expression<String>? title,
    Expression<String>? status,
    Expression<int>? startedAt,
    Expression<int>? endedAt,
    Expression<int>? durationMs,
    Expression<int>? pausedDurationMs,
    Expression<double>? distanceMeters,
    Expression<double>? avgPaceSecPerKm,
    Expression<double>? avgSpeedMps,
    Expression<double>? maxSpeedMps,
    Expression<double>? caloriesKcal,
    Expression<int>? steps,
    Expression<double>? elevationGainM,
    Expression<double>? elevationLossM,
    Expression<double>? startLat,
    Expression<double>? startLng,
    Expression<double>? endLat,
    Expression<double>? endLng,
    Expression<String>? boundsJson,
    Expression<String>? polylineEncoded,
    Expression<int>? pointCount,
    Expression<String>? syncStatus,
    Expression<String>? syncError,
    Expression<int>? syncVersion,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (status != null) 'status': status,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (durationMs != null) 'duration_ms': durationMs,
      if (pausedDurationMs != null) 'paused_duration_ms': pausedDurationMs,
      if (distanceMeters != null) 'distance_meters': distanceMeters,
      if (avgPaceSecPerKm != null) 'avg_pace_sec_per_km': avgPaceSecPerKm,
      if (avgSpeedMps != null) 'avg_speed_mps': avgSpeedMps,
      if (maxSpeedMps != null) 'max_speed_mps': maxSpeedMps,
      if (caloriesKcal != null) 'calories_kcal': caloriesKcal,
      if (steps != null) 'steps': steps,
      if (elevationGainM != null) 'elevation_gain_m': elevationGainM,
      if (elevationLossM != null) 'elevation_loss_m': elevationLossM,
      if (startLat != null) 'start_lat': startLat,
      if (startLng != null) 'start_lng': startLng,
      if (endLat != null) 'end_lat': endLat,
      if (endLng != null) 'end_lng': endLng,
      if (boundsJson != null) 'bounds_json': boundsJson,
      if (polylineEncoded != null) 'polyline_encoded': polylineEncoded,
      if (pointCount != null) 'point_count': pointCount,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (syncError != null) 'sync_error': syncError,
      if (syncVersion != null) 'sync_version': syncVersion,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WalksCompanion copyWith({
    Value<String>? id,
    Value<String?>? remoteId,
    Value<String>? userId,
    Value<String?>? title,
    Value<String>? status,
    Value<int>? startedAt,
    Value<int?>? endedAt,
    Value<int>? durationMs,
    Value<int>? pausedDurationMs,
    Value<double>? distanceMeters,
    Value<double>? avgPaceSecPerKm,
    Value<double>? avgSpeedMps,
    Value<double>? maxSpeedMps,
    Value<double>? caloriesKcal,
    Value<int>? steps,
    Value<double>? elevationGainM,
    Value<double>? elevationLossM,
    Value<double?>? startLat,
    Value<double?>? startLng,
    Value<double?>? endLat,
    Value<double?>? endLng,
    Value<String?>? boundsJson,
    Value<String?>? polylineEncoded,
    Value<int>? pointCount,
    Value<String>? syncStatus,
    Value<String?>? syncError,
    Value<int>? syncVersion,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return WalksCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      durationMs: durationMs ?? this.durationMs,
      pausedDurationMs: pausedDurationMs ?? this.pausedDurationMs,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      avgPaceSecPerKm: avgPaceSecPerKm ?? this.avgPaceSecPerKm,
      avgSpeedMps: avgSpeedMps ?? this.avgSpeedMps,
      maxSpeedMps: maxSpeedMps ?? this.maxSpeedMps,
      caloriesKcal: caloriesKcal ?? this.caloriesKcal,
      steps: steps ?? this.steps,
      elevationGainM: elevationGainM ?? this.elevationGainM,
      elevationLossM: elevationLossM ?? this.elevationLossM,
      startLat: startLat ?? this.startLat,
      startLng: startLng ?? this.startLng,
      endLat: endLat ?? this.endLat,
      endLng: endLng ?? this.endLng,
      boundsJson: boundsJson ?? this.boundsJson,
      polylineEncoded: polylineEncoded ?? this.polylineEncoded,
      pointCount: pointCount ?? this.pointCount,
      syncStatus: syncStatus ?? this.syncStatus,
      syncError: syncError ?? this.syncError,
      syncVersion: syncVersion ?? this.syncVersion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<int>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<int>(endedAt.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (pausedDurationMs.present) {
      map['paused_duration_ms'] = Variable<int>(pausedDurationMs.value);
    }
    if (distanceMeters.present) {
      map['distance_meters'] = Variable<double>(distanceMeters.value);
    }
    if (avgPaceSecPerKm.present) {
      map['avg_pace_sec_per_km'] = Variable<double>(avgPaceSecPerKm.value);
    }
    if (avgSpeedMps.present) {
      map['avg_speed_mps'] = Variable<double>(avgSpeedMps.value);
    }
    if (maxSpeedMps.present) {
      map['max_speed_mps'] = Variable<double>(maxSpeedMps.value);
    }
    if (caloriesKcal.present) {
      map['calories_kcal'] = Variable<double>(caloriesKcal.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (elevationGainM.present) {
      map['elevation_gain_m'] = Variable<double>(elevationGainM.value);
    }
    if (elevationLossM.present) {
      map['elevation_loss_m'] = Variable<double>(elevationLossM.value);
    }
    if (startLat.present) {
      map['start_lat'] = Variable<double>(startLat.value);
    }
    if (startLng.present) {
      map['start_lng'] = Variable<double>(startLng.value);
    }
    if (endLat.present) {
      map['end_lat'] = Variable<double>(endLat.value);
    }
    if (endLng.present) {
      map['end_lng'] = Variable<double>(endLng.value);
    }
    if (boundsJson.present) {
      map['bounds_json'] = Variable<String>(boundsJson.value);
    }
    if (polylineEncoded.present) {
      map['polyline_encoded'] = Variable<String>(polylineEncoded.value);
    }
    if (pointCount.present) {
      map['point_count'] = Variable<int>(pointCount.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (syncError.present) {
      map['sync_error'] = Variable<String>(syncError.value);
    }
    if (syncVersion.present) {
      map['sync_version'] = Variable<int>(syncVersion.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalksCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationMs: $durationMs, ')
          ..write('pausedDurationMs: $pausedDurationMs, ')
          ..write('distanceMeters: $distanceMeters, ')
          ..write('avgPaceSecPerKm: $avgPaceSecPerKm, ')
          ..write('avgSpeedMps: $avgSpeedMps, ')
          ..write('maxSpeedMps: $maxSpeedMps, ')
          ..write('caloriesKcal: $caloriesKcal, ')
          ..write('steps: $steps, ')
          ..write('elevationGainM: $elevationGainM, ')
          ..write('elevationLossM: $elevationLossM, ')
          ..write('startLat: $startLat, ')
          ..write('startLng: $startLng, ')
          ..write('endLat: $endLat, ')
          ..write('endLng: $endLng, ')
          ..write('boundsJson: $boundsJson, ')
          ..write('polylineEncoded: $polylineEncoded, ')
          ..write('pointCount: $pointCount, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncError: $syncError, ')
          ..write('syncVersion: $syncVersion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WalkPointsTable extends WalkPoints
    with TableInfo<$WalkPointsTable, WalkPoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalkPointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _walkIdMeta = const VerificationMeta('walkId');
  @override
  late final GeneratedColumn<String> walkId = GeneratedColumn<String>(
    'walk_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES walks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<int> recordedAt = GeneratedColumn<int>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
    'lng',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _altitudeMeta = const VerificationMeta(
    'altitude',
  );
  @override
  late final GeneratedColumn<double> altitude = GeneratedColumn<double>(
    'altitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMeta = const VerificationMeta(
    'accuracy',
  );
  @override
  late final GeneratedColumn<double> accuracy = GeneratedColumn<double>(
    'accuracy',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<double> speed = GeneratedColumn<double>(
    'speed',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bearingMeta = const VerificationMeta(
    'bearing',
  );
  @override
  late final GeneratedColumn<double> bearing = GeneratedColumn<double>(
    'bearing',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFilteredMeta = const VerificationMeta(
    'isFiltered',
  );
  @override
  late final GeneratedColumn<bool> isFiltered = GeneratedColumn<bool>(
    'is_filtered',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_filtered" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    walkId,
    recordedAt,
    lat,
    lng,
    altitude,
    accuracy,
    speed,
    bearing,
    isFiltered,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'walk_points';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalkPoint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('walk_id')) {
      context.handle(
        _walkIdMeta,
        walkId.isAcceptableOrUnknown(data['walk_id']!, _walkIdMeta),
      );
    } else if (isInserting) {
      context.missing(_walkIdMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
        _lngMeta,
        lng.isAcceptableOrUnknown(data['lng']!, _lngMeta),
      );
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    if (data.containsKey('altitude')) {
      context.handle(
        _altitudeMeta,
        altitude.isAcceptableOrUnknown(data['altitude']!, _altitudeMeta),
      );
    }
    if (data.containsKey('accuracy')) {
      context.handle(
        _accuracyMeta,
        accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta),
      );
    }
    if (data.containsKey('speed')) {
      context.handle(
        _speedMeta,
        speed.isAcceptableOrUnknown(data['speed']!, _speedMeta),
      );
    }
    if (data.containsKey('bearing')) {
      context.handle(
        _bearingMeta,
        bearing.isAcceptableOrUnknown(data['bearing']!, _bearingMeta),
      );
    }
    if (data.containsKey('is_filtered')) {
      context.handle(
        _isFilteredMeta,
        isFiltered.isAcceptableOrUnknown(data['is_filtered']!, _isFilteredMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WalkPoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalkPoint(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      walkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}walk_id'],
      )!,
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recorded_at'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lng'],
      )!,
      altitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}altitude'],
      ),
      accuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy'],
      ),
      speed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speed'],
      ),
      bearing: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bearing'],
      ),
      isFiltered: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_filtered'],
      )!,
    );
  }

  @override
  $WalkPointsTable createAlias(String alias) {
    return $WalkPointsTable(attachedDatabase, alias);
  }
}

class WalkPoint extends DataClass implements Insertable<WalkPoint> {
  final int id;
  final String walkId;
  final int recordedAt;
  final double lat;
  final double lng;
  final double? altitude;
  final double? accuracy;
  final double? speed;
  final double? bearing;
  final bool isFiltered;
  const WalkPoint({
    required this.id,
    required this.walkId,
    required this.recordedAt,
    required this.lat,
    required this.lng,
    this.altitude,
    this.accuracy,
    this.speed,
    this.bearing,
    required this.isFiltered,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['walk_id'] = Variable<String>(walkId);
    map['recorded_at'] = Variable<int>(recordedAt);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    if (!nullToAbsent || altitude != null) {
      map['altitude'] = Variable<double>(altitude);
    }
    if (!nullToAbsent || accuracy != null) {
      map['accuracy'] = Variable<double>(accuracy);
    }
    if (!nullToAbsent || speed != null) {
      map['speed'] = Variable<double>(speed);
    }
    if (!nullToAbsent || bearing != null) {
      map['bearing'] = Variable<double>(bearing);
    }
    map['is_filtered'] = Variable<bool>(isFiltered);
    return map;
  }

  WalkPointsCompanion toCompanion(bool nullToAbsent) {
    return WalkPointsCompanion(
      id: Value(id),
      walkId: Value(walkId),
      recordedAt: Value(recordedAt),
      lat: Value(lat),
      lng: Value(lng),
      altitude: altitude == null && nullToAbsent
          ? const Value.absent()
          : Value(altitude),
      accuracy: accuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracy),
      speed: speed == null && nullToAbsent
          ? const Value.absent()
          : Value(speed),
      bearing: bearing == null && nullToAbsent
          ? const Value.absent()
          : Value(bearing),
      isFiltered: Value(isFiltered),
    );
  }

  factory WalkPoint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalkPoint(
      id: serializer.fromJson<int>(json['id']),
      walkId: serializer.fromJson<String>(json['walkId']),
      recordedAt: serializer.fromJson<int>(json['recordedAt']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
      altitude: serializer.fromJson<double?>(json['altitude']),
      accuracy: serializer.fromJson<double?>(json['accuracy']),
      speed: serializer.fromJson<double?>(json['speed']),
      bearing: serializer.fromJson<double?>(json['bearing']),
      isFiltered: serializer.fromJson<bool>(json['isFiltered']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'walkId': serializer.toJson<String>(walkId),
      'recordedAt': serializer.toJson<int>(recordedAt),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
      'altitude': serializer.toJson<double?>(altitude),
      'accuracy': serializer.toJson<double?>(accuracy),
      'speed': serializer.toJson<double?>(speed),
      'bearing': serializer.toJson<double?>(bearing),
      'isFiltered': serializer.toJson<bool>(isFiltered),
    };
  }

  WalkPoint copyWith({
    int? id,
    String? walkId,
    int? recordedAt,
    double? lat,
    double? lng,
    Value<double?> altitude = const Value.absent(),
    Value<double?> accuracy = const Value.absent(),
    Value<double?> speed = const Value.absent(),
    Value<double?> bearing = const Value.absent(),
    bool? isFiltered,
  }) => WalkPoint(
    id: id ?? this.id,
    walkId: walkId ?? this.walkId,
    recordedAt: recordedAt ?? this.recordedAt,
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
    altitude: altitude.present ? altitude.value : this.altitude,
    accuracy: accuracy.present ? accuracy.value : this.accuracy,
    speed: speed.present ? speed.value : this.speed,
    bearing: bearing.present ? bearing.value : this.bearing,
    isFiltered: isFiltered ?? this.isFiltered,
  );
  WalkPoint copyWithCompanion(WalkPointsCompanion data) {
    return WalkPoint(
      id: data.id.present ? data.id.value : this.id,
      walkId: data.walkId.present ? data.walkId.value : this.walkId,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
      altitude: data.altitude.present ? data.altitude.value : this.altitude,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      speed: data.speed.present ? data.speed.value : this.speed,
      bearing: data.bearing.present ? data.bearing.value : this.bearing,
      isFiltered: data.isFiltered.present
          ? data.isFiltered.value
          : this.isFiltered,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalkPoint(')
          ..write('id: $id, ')
          ..write('walkId: $walkId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('altitude: $altitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('speed: $speed, ')
          ..write('bearing: $bearing, ')
          ..write('isFiltered: $isFiltered')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    walkId,
    recordedAt,
    lat,
    lng,
    altitude,
    accuracy,
    speed,
    bearing,
    isFiltered,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalkPoint &&
          other.id == this.id &&
          other.walkId == this.walkId &&
          other.recordedAt == this.recordedAt &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.altitude == this.altitude &&
          other.accuracy == this.accuracy &&
          other.speed == this.speed &&
          other.bearing == this.bearing &&
          other.isFiltered == this.isFiltered);
}

class WalkPointsCompanion extends UpdateCompanion<WalkPoint> {
  final Value<int> id;
  final Value<String> walkId;
  final Value<int> recordedAt;
  final Value<double> lat;
  final Value<double> lng;
  final Value<double?> altitude;
  final Value<double?> accuracy;
  final Value<double?> speed;
  final Value<double?> bearing;
  final Value<bool> isFiltered;
  const WalkPointsCompanion({
    this.id = const Value.absent(),
    this.walkId = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.altitude = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.speed = const Value.absent(),
    this.bearing = const Value.absent(),
    this.isFiltered = const Value.absent(),
  });
  WalkPointsCompanion.insert({
    this.id = const Value.absent(),
    required String walkId,
    required int recordedAt,
    required double lat,
    required double lng,
    this.altitude = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.speed = const Value.absent(),
    this.bearing = const Value.absent(),
    this.isFiltered = const Value.absent(),
  }) : walkId = Value(walkId),
       recordedAt = Value(recordedAt),
       lat = Value(lat),
       lng = Value(lng);
  static Insertable<WalkPoint> custom({
    Expression<int>? id,
    Expression<String>? walkId,
    Expression<int>? recordedAt,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<double>? altitude,
    Expression<double>? accuracy,
    Expression<double>? speed,
    Expression<double>? bearing,
    Expression<bool>? isFiltered,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (walkId != null) 'walk_id': walkId,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (altitude != null) 'altitude': altitude,
      if (accuracy != null) 'accuracy': accuracy,
      if (speed != null) 'speed': speed,
      if (bearing != null) 'bearing': bearing,
      if (isFiltered != null) 'is_filtered': isFiltered,
    });
  }

  WalkPointsCompanion copyWith({
    Value<int>? id,
    Value<String>? walkId,
    Value<int>? recordedAt,
    Value<double>? lat,
    Value<double>? lng,
    Value<double?>? altitude,
    Value<double?>? accuracy,
    Value<double?>? speed,
    Value<double?>? bearing,
    Value<bool>? isFiltered,
  }) {
    return WalkPointsCompanion(
      id: id ?? this.id,
      walkId: walkId ?? this.walkId,
      recordedAt: recordedAt ?? this.recordedAt,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      altitude: altitude ?? this.altitude,
      accuracy: accuracy ?? this.accuracy,
      speed: speed ?? this.speed,
      bearing: bearing ?? this.bearing,
      isFiltered: isFiltered ?? this.isFiltered,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (walkId.present) {
      map['walk_id'] = Variable<String>(walkId.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<int>(recordedAt.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (altitude.present) {
      map['altitude'] = Variable<double>(altitude.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<double>(accuracy.value);
    }
    if (speed.present) {
      map['speed'] = Variable<double>(speed.value);
    }
    if (bearing.present) {
      map['bearing'] = Variable<double>(bearing.value);
    }
    if (isFiltered.present) {
      map['is_filtered'] = Variable<bool>(isFiltered.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalkPointsCompanion(')
          ..write('id: $id, ')
          ..write('walkId: $walkId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('altitude: $altitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('speed: $speed, ')
          ..write('bearing: $bearing, ')
          ..write('isFiltered: $isFiltered')
          ..write(')'))
        .toString();
  }
}

class $WalkPausesTable extends WalkPauses
    with TableInfo<$WalkPausesTable, WalkPause> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalkPausesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _walkIdMeta = const VerificationMeta('walkId');
  @override
  late final GeneratedColumn<String> walkId = GeneratedColumn<String>(
    'walk_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES walks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pausedAtMeta = const VerificationMeta(
    'pausedAt',
  );
  @override
  late final GeneratedColumn<int> pausedAt = GeneratedColumn<int>(
    'paused_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resumedAtMeta = const VerificationMeta(
    'resumedAt',
  );
  @override
  late final GeneratedColumn<int> resumedAt = GeneratedColumn<int>(
    'resumed_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, walkId, pausedAt, resumedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'walk_pauses';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalkPause> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('walk_id')) {
      context.handle(
        _walkIdMeta,
        walkId.isAcceptableOrUnknown(data['walk_id']!, _walkIdMeta),
      );
    } else if (isInserting) {
      context.missing(_walkIdMeta);
    }
    if (data.containsKey('paused_at')) {
      context.handle(
        _pausedAtMeta,
        pausedAt.isAcceptableOrUnknown(data['paused_at']!, _pausedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_pausedAtMeta);
    }
    if (data.containsKey('resumed_at')) {
      context.handle(
        _resumedAtMeta,
        resumedAt.isAcceptableOrUnknown(data['resumed_at']!, _resumedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WalkPause map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalkPause(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      walkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}walk_id'],
      )!,
      pausedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paused_at'],
      )!,
      resumedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}resumed_at'],
      ),
    );
  }

  @override
  $WalkPausesTable createAlias(String alias) {
    return $WalkPausesTable(attachedDatabase, alias);
  }
}

class WalkPause extends DataClass implements Insertable<WalkPause> {
  final int id;
  final String walkId;
  final int pausedAt;
  final int? resumedAt;
  const WalkPause({
    required this.id,
    required this.walkId,
    required this.pausedAt,
    this.resumedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['walk_id'] = Variable<String>(walkId);
    map['paused_at'] = Variable<int>(pausedAt);
    if (!nullToAbsent || resumedAt != null) {
      map['resumed_at'] = Variable<int>(resumedAt);
    }
    return map;
  }

  WalkPausesCompanion toCompanion(bool nullToAbsent) {
    return WalkPausesCompanion(
      id: Value(id),
      walkId: Value(walkId),
      pausedAt: Value(pausedAt),
      resumedAt: resumedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(resumedAt),
    );
  }

  factory WalkPause.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalkPause(
      id: serializer.fromJson<int>(json['id']),
      walkId: serializer.fromJson<String>(json['walkId']),
      pausedAt: serializer.fromJson<int>(json['pausedAt']),
      resumedAt: serializer.fromJson<int?>(json['resumedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'walkId': serializer.toJson<String>(walkId),
      'pausedAt': serializer.toJson<int>(pausedAt),
      'resumedAt': serializer.toJson<int?>(resumedAt),
    };
  }

  WalkPause copyWith({
    int? id,
    String? walkId,
    int? pausedAt,
    Value<int?> resumedAt = const Value.absent(),
  }) => WalkPause(
    id: id ?? this.id,
    walkId: walkId ?? this.walkId,
    pausedAt: pausedAt ?? this.pausedAt,
    resumedAt: resumedAt.present ? resumedAt.value : this.resumedAt,
  );
  WalkPause copyWithCompanion(WalkPausesCompanion data) {
    return WalkPause(
      id: data.id.present ? data.id.value : this.id,
      walkId: data.walkId.present ? data.walkId.value : this.walkId,
      pausedAt: data.pausedAt.present ? data.pausedAt.value : this.pausedAt,
      resumedAt: data.resumedAt.present ? data.resumedAt.value : this.resumedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalkPause(')
          ..write('id: $id, ')
          ..write('walkId: $walkId, ')
          ..write('pausedAt: $pausedAt, ')
          ..write('resumedAt: $resumedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, walkId, pausedAt, resumedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalkPause &&
          other.id == this.id &&
          other.walkId == this.walkId &&
          other.pausedAt == this.pausedAt &&
          other.resumedAt == this.resumedAt);
}

class WalkPausesCompanion extends UpdateCompanion<WalkPause> {
  final Value<int> id;
  final Value<String> walkId;
  final Value<int> pausedAt;
  final Value<int?> resumedAt;
  const WalkPausesCompanion({
    this.id = const Value.absent(),
    this.walkId = const Value.absent(),
    this.pausedAt = const Value.absent(),
    this.resumedAt = const Value.absent(),
  });
  WalkPausesCompanion.insert({
    this.id = const Value.absent(),
    required String walkId,
    required int pausedAt,
    this.resumedAt = const Value.absent(),
  }) : walkId = Value(walkId),
       pausedAt = Value(pausedAt);
  static Insertable<WalkPause> custom({
    Expression<int>? id,
    Expression<String>? walkId,
    Expression<int>? pausedAt,
    Expression<int>? resumedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (walkId != null) 'walk_id': walkId,
      if (pausedAt != null) 'paused_at': pausedAt,
      if (resumedAt != null) 'resumed_at': resumedAt,
    });
  }

  WalkPausesCompanion copyWith({
    Value<int>? id,
    Value<String>? walkId,
    Value<int>? pausedAt,
    Value<int?>? resumedAt,
  }) {
    return WalkPausesCompanion(
      id: id ?? this.id,
      walkId: walkId ?? this.walkId,
      pausedAt: pausedAt ?? this.pausedAt,
      resumedAt: resumedAt ?? this.resumedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (walkId.present) {
      map['walk_id'] = Variable<String>(walkId.value);
    }
    if (pausedAt.present) {
      map['paused_at'] = Variable<int>(pausedAt.value);
    }
    if (resumedAt.present) {
      map['resumed_at'] = Variable<int>(resumedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalkPausesCompanion(')
          ..write('id: $id, ')
          ..write('walkId: $walkId, ')
          ..write('pausedAt: $pausedAt, ')
          ..write('resumedAt: $resumedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextAttemptAtMeta = const VerificationMeta(
    'nextAttemptAt',
  );
  @override
  late final GeneratedColumn<int> nextAttemptAt = GeneratedColumn<int>(
    'next_attempt_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    operation,
    payloadJson,
    attempts,
    nextAttemptAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('next_attempt_at')) {
      context.handle(
        _nextAttemptAtMeta,
        nextAttemptAt.isAcceptableOrUnknown(
          data['next_attempt_at']!,
          _nextAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      ),
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      nextAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_attempt_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String entityType;
  final String entityId;
  final String operation;
  final String? payloadJson;
  final int attempts;
  final int nextAttemptAt;
  final int createdAt;
  const SyncQueueData({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.operation,
    this.payloadJson,
    required this.attempts,
    required this.nextAttemptAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    if (!nullToAbsent || payloadJson != null) {
      map['payload_json'] = Variable<String>(payloadJson);
    }
    map['attempts'] = Variable<int>(attempts);
    map['next_attempt_at'] = Variable<int>(nextAttemptAt);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      payloadJson: payloadJson == null && nullToAbsent
          ? const Value.absent()
          : Value(payloadJson),
      attempts: Value(attempts),
      nextAttemptAt: Value(nextAttemptAt),
      createdAt: Value(createdAt),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String?>(json['payloadJson']),
      attempts: serializer.fromJson<int>(json['attempts']),
      nextAttemptAt: serializer.fromJson<int>(json['nextAttemptAt']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String?>(payloadJson),
      'attempts': serializer.toJson<int>(attempts),
      'nextAttemptAt': serializer.toJson<int>(nextAttemptAt),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  SyncQueueData copyWith({
    int? id,
    String? entityType,
    String? entityId,
    String? operation,
    Value<String?> payloadJson = const Value.absent(),
    int? attempts,
    int? nextAttemptAt,
    int? createdAt,
  }) => SyncQueueData(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    operation: operation ?? this.operation,
    payloadJson: payloadJson.present ? payloadJson.value : this.payloadJson,
    attempts: attempts ?? this.attempts,
    nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      nextAttemptAt: data.nextAttemptAt.present
          ? data.nextAttemptAt.value
          : this.nextAttemptAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('attempts: $attempts, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    operation,
    payloadJson,
    attempts,
    nextAttemptAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.attempts == this.attempts &&
          other.nextAttemptAt == this.nextAttemptAt &&
          other.createdAt == this.createdAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String?> payloadJson;
  final Value<int> attempts;
  final Value<int> nextAttemptAt;
  final Value<int> createdAt;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.attempts = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required String entityId,
    required String operation,
    this.payloadJson = const Value.absent(),
    this.attempts = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    required int createdAt,
  }) : entityType = Value(entityType),
       entityId = Value(entityId),
       operation = Value(operation),
       createdAt = Value(createdAt);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<int>? attempts,
    Expression<int>? nextAttemptAt,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (attempts != null) 'attempts': attempts,
      if (nextAttemptAt != null) 'next_attempt_at': nextAttemptAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SyncQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? operation,
    Value<String?>? payloadJson,
    Value<int>? attempts,
    Value<int>? nextAttemptAt,
    Value<int>? createdAt,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      attempts: attempts ?? this.attempts,
      nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (nextAttemptAt.present) {
      map['next_attempt_at'] = Variable<int>(nextAttemptAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('attempts: $attempts, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  const AppSetting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(key: Value(key), value: Value(value));
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSetting copyWith({String? key, String? value}) =>
      AppSetting(key: key ?? this.key, value: value ?? this.value);
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WalksTable walks = $WalksTable(this);
  late final $WalkPointsTable walkPoints = $WalkPointsTable(this);
  late final $WalkPausesTable walkPauses = $WalkPausesTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final WalksDao walksDao = WalksDao(this as AppDatabase);
  late final WalkPointsDao walkPointsDao = WalkPointsDao(this as AppDatabase);
  late final WalkPausesDao walkPausesDao = WalkPausesDao(this as AppDatabase);
  late final SyncQueueDao syncQueueDao = SyncQueueDao(this as AppDatabase);
  late final AppSettingsDao appSettingsDao = AppSettingsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    walks,
    walkPoints,
    walkPauses,
    syncQueue,
    appSettings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'walks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('walk_points', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'walks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('walk_pauses', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$WalksTableCreateCompanionBuilder =
    WalksCompanion Function({
      required String id,
      Value<String?> remoteId,
      required String userId,
      Value<String?> title,
      required String status,
      required int startedAt,
      Value<int?> endedAt,
      Value<int> durationMs,
      Value<int> pausedDurationMs,
      Value<double> distanceMeters,
      Value<double> avgPaceSecPerKm,
      Value<double> avgSpeedMps,
      Value<double> maxSpeedMps,
      Value<double> caloriesKcal,
      Value<int> steps,
      Value<double> elevationGainM,
      Value<double> elevationLossM,
      Value<double?> startLat,
      Value<double?> startLng,
      Value<double?> endLat,
      Value<double?> endLng,
      Value<String?> boundsJson,
      Value<String?> polylineEncoded,
      Value<int> pointCount,
      Value<String> syncStatus,
      Value<String?> syncError,
      Value<int> syncVersion,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$WalksTableUpdateCompanionBuilder =
    WalksCompanion Function({
      Value<String> id,
      Value<String?> remoteId,
      Value<String> userId,
      Value<String?> title,
      Value<String> status,
      Value<int> startedAt,
      Value<int?> endedAt,
      Value<int> durationMs,
      Value<int> pausedDurationMs,
      Value<double> distanceMeters,
      Value<double> avgPaceSecPerKm,
      Value<double> avgSpeedMps,
      Value<double> maxSpeedMps,
      Value<double> caloriesKcal,
      Value<int> steps,
      Value<double> elevationGainM,
      Value<double> elevationLossM,
      Value<double?> startLat,
      Value<double?> startLng,
      Value<double?> endLat,
      Value<double?> endLng,
      Value<String?> boundsJson,
      Value<String?> polylineEncoded,
      Value<int> pointCount,
      Value<String> syncStatus,
      Value<String?> syncError,
      Value<int> syncVersion,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

final class $$WalksTableReferences
    extends BaseReferences<_$AppDatabase, $WalksTable, Walk> {
  $$WalksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WalkPointsTable, List<WalkPoint>>
  _walkPointsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.walkPoints,
    aliasName: $_aliasNameGenerator(db.walks.id, db.walkPoints.walkId),
  );

  $$WalkPointsTableProcessedTableManager get walkPointsRefs {
    final manager = $$WalkPointsTableTableManager(
      $_db,
      $_db.walkPoints,
    ).filter((f) => f.walkId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_walkPointsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WalkPausesTable, List<WalkPause>>
  _walkPausesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.walkPauses,
    aliasName: $_aliasNameGenerator(db.walks.id, db.walkPauses.walkId),
  );

  $$WalkPausesTableProcessedTableManager get walkPausesRefs {
    final manager = $$WalkPausesTableTableManager(
      $_db,
      $_db.walkPauses,
    ).filter((f) => f.walkId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_walkPausesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WalksTableFilterComposer extends Composer<_$AppDatabase, $WalksTable> {
  $$WalksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pausedDurationMs => $composableBuilder(
    column: $table.pausedDurationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceMeters => $composableBuilder(
    column: $table.distanceMeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgPaceSecPerKm => $composableBuilder(
    column: $table.avgPaceSecPerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgSpeedMps => $composableBuilder(
    column: $table.avgSpeedMps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxSpeedMps => $composableBuilder(
    column: $table.maxSpeedMps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get elevationGainM => $composableBuilder(
    column: $table.elevationGainM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get elevationLossM => $composableBuilder(
    column: $table.elevationLossM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startLat => $composableBuilder(
    column: $table.startLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startLng => $composableBuilder(
    column: $table.startLng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get endLat => $composableBuilder(
    column: $table.endLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get endLng => $composableBuilder(
    column: $table.endLng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boundsJson => $composableBuilder(
    column: $table.boundsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get polylineEncoded => $composableBuilder(
    column: $table.polylineEncoded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointCount => $composableBuilder(
    column: $table.pointCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncVersion => $composableBuilder(
    column: $table.syncVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> walkPointsRefs(
    Expression<bool> Function($$WalkPointsTableFilterComposer f) f,
  ) {
    final $$WalkPointsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.walkPoints,
      getReferencedColumn: (t) => t.walkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalkPointsTableFilterComposer(
            $db: $db,
            $table: $db.walkPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> walkPausesRefs(
    Expression<bool> Function($$WalkPausesTableFilterComposer f) f,
  ) {
    final $$WalkPausesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.walkPauses,
      getReferencedColumn: (t) => t.walkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalkPausesTableFilterComposer(
            $db: $db,
            $table: $db.walkPauses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WalksTableOrderingComposer
    extends Composer<_$AppDatabase, $WalksTable> {
  $$WalksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pausedDurationMs => $composableBuilder(
    column: $table.pausedDurationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceMeters => $composableBuilder(
    column: $table.distanceMeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgPaceSecPerKm => $composableBuilder(
    column: $table.avgPaceSecPerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgSpeedMps => $composableBuilder(
    column: $table.avgSpeedMps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxSpeedMps => $composableBuilder(
    column: $table.maxSpeedMps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get elevationGainM => $composableBuilder(
    column: $table.elevationGainM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get elevationLossM => $composableBuilder(
    column: $table.elevationLossM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startLat => $composableBuilder(
    column: $table.startLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startLng => $composableBuilder(
    column: $table.startLng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get endLat => $composableBuilder(
    column: $table.endLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get endLng => $composableBuilder(
    column: $table.endLng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boundsJson => $composableBuilder(
    column: $table.boundsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get polylineEncoded => $composableBuilder(
    column: $table.polylineEncoded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointCount => $composableBuilder(
    column: $table.pointCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncVersion => $composableBuilder(
    column: $table.syncVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WalksTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalksTable> {
  $$WalksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pausedDurationMs => $composableBuilder(
    column: $table.pausedDurationMs,
    builder: (column) => column,
  );

  GeneratedColumn<double> get distanceMeters => $composableBuilder(
    column: $table.distanceMeters,
    builder: (column) => column,
  );

  GeneratedColumn<double> get avgPaceSecPerKm => $composableBuilder(
    column: $table.avgPaceSecPerKm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get avgSpeedMps => $composableBuilder(
    column: $table.avgSpeedMps,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxSpeedMps => $composableBuilder(
    column: $table.maxSpeedMps,
    builder: (column) => column,
  );

  GeneratedColumn<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<double> get elevationGainM => $composableBuilder(
    column: $table.elevationGainM,
    builder: (column) => column,
  );

  GeneratedColumn<double> get elevationLossM => $composableBuilder(
    column: $table.elevationLossM,
    builder: (column) => column,
  );

  GeneratedColumn<double> get startLat =>
      $composableBuilder(column: $table.startLat, builder: (column) => column);

  GeneratedColumn<double> get startLng =>
      $composableBuilder(column: $table.startLng, builder: (column) => column);

  GeneratedColumn<double> get endLat =>
      $composableBuilder(column: $table.endLat, builder: (column) => column);

  GeneratedColumn<double> get endLng =>
      $composableBuilder(column: $table.endLng, builder: (column) => column);

  GeneratedColumn<String> get boundsJson => $composableBuilder(
    column: $table.boundsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get polylineEncoded => $composableBuilder(
    column: $table.polylineEncoded,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pointCount => $composableBuilder(
    column: $table.pointCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncError =>
      $composableBuilder(column: $table.syncError, builder: (column) => column);

  GeneratedColumn<int> get syncVersion => $composableBuilder(
    column: $table.syncVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> walkPointsRefs<T extends Object>(
    Expression<T> Function($$WalkPointsTableAnnotationComposer a) f,
  ) {
    final $$WalkPointsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.walkPoints,
      getReferencedColumn: (t) => t.walkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalkPointsTableAnnotationComposer(
            $db: $db,
            $table: $db.walkPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> walkPausesRefs<T extends Object>(
    Expression<T> Function($$WalkPausesTableAnnotationComposer a) f,
  ) {
    final $$WalkPausesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.walkPauses,
      getReferencedColumn: (t) => t.walkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalkPausesTableAnnotationComposer(
            $db: $db,
            $table: $db.walkPauses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WalksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalksTable,
          Walk,
          $$WalksTableFilterComposer,
          $$WalksTableOrderingComposer,
          $$WalksTableAnnotationComposer,
          $$WalksTableCreateCompanionBuilder,
          $$WalksTableUpdateCompanionBuilder,
          (Walk, $$WalksTableReferences),
          Walk,
          PrefetchHooks Function({bool walkPointsRefs, bool walkPausesRefs})
        > {
  $$WalksTableTableManager(_$AppDatabase db, $WalksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> startedAt = const Value.absent(),
                Value<int?> endedAt = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
                Value<int> pausedDurationMs = const Value.absent(),
                Value<double> distanceMeters = const Value.absent(),
                Value<double> avgPaceSecPerKm = const Value.absent(),
                Value<double> avgSpeedMps = const Value.absent(),
                Value<double> maxSpeedMps = const Value.absent(),
                Value<double> caloriesKcal = const Value.absent(),
                Value<int> steps = const Value.absent(),
                Value<double> elevationGainM = const Value.absent(),
                Value<double> elevationLossM = const Value.absent(),
                Value<double?> startLat = const Value.absent(),
                Value<double?> startLng = const Value.absent(),
                Value<double?> endLat = const Value.absent(),
                Value<double?> endLng = const Value.absent(),
                Value<String?> boundsJson = const Value.absent(),
                Value<String?> polylineEncoded = const Value.absent(),
                Value<int> pointCount = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<int> syncVersion = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalksCompanion(
                id: id,
                remoteId: remoteId,
                userId: userId,
                title: title,
                status: status,
                startedAt: startedAt,
                endedAt: endedAt,
                durationMs: durationMs,
                pausedDurationMs: pausedDurationMs,
                distanceMeters: distanceMeters,
                avgPaceSecPerKm: avgPaceSecPerKm,
                avgSpeedMps: avgSpeedMps,
                maxSpeedMps: maxSpeedMps,
                caloriesKcal: caloriesKcal,
                steps: steps,
                elevationGainM: elevationGainM,
                elevationLossM: elevationLossM,
                startLat: startLat,
                startLng: startLng,
                endLat: endLat,
                endLng: endLng,
                boundsJson: boundsJson,
                polylineEncoded: polylineEncoded,
                pointCount: pointCount,
                syncStatus: syncStatus,
                syncError: syncError,
                syncVersion: syncVersion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> remoteId = const Value.absent(),
                required String userId,
                Value<String?> title = const Value.absent(),
                required String status,
                required int startedAt,
                Value<int?> endedAt = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
                Value<int> pausedDurationMs = const Value.absent(),
                Value<double> distanceMeters = const Value.absent(),
                Value<double> avgPaceSecPerKm = const Value.absent(),
                Value<double> avgSpeedMps = const Value.absent(),
                Value<double> maxSpeedMps = const Value.absent(),
                Value<double> caloriesKcal = const Value.absent(),
                Value<int> steps = const Value.absent(),
                Value<double> elevationGainM = const Value.absent(),
                Value<double> elevationLossM = const Value.absent(),
                Value<double?> startLat = const Value.absent(),
                Value<double?> startLng = const Value.absent(),
                Value<double?> endLat = const Value.absent(),
                Value<double?> endLng = const Value.absent(),
                Value<String?> boundsJson = const Value.absent(),
                Value<String?> polylineEncoded = const Value.absent(),
                Value<int> pointCount = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<int> syncVersion = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => WalksCompanion.insert(
                id: id,
                remoteId: remoteId,
                userId: userId,
                title: title,
                status: status,
                startedAt: startedAt,
                endedAt: endedAt,
                durationMs: durationMs,
                pausedDurationMs: pausedDurationMs,
                distanceMeters: distanceMeters,
                avgPaceSecPerKm: avgPaceSecPerKm,
                avgSpeedMps: avgSpeedMps,
                maxSpeedMps: maxSpeedMps,
                caloriesKcal: caloriesKcal,
                steps: steps,
                elevationGainM: elevationGainM,
                elevationLossM: elevationLossM,
                startLat: startLat,
                startLng: startLng,
                endLat: endLat,
                endLng: endLng,
                boundsJson: boundsJson,
                polylineEncoded: polylineEncoded,
                pointCount: pointCount,
                syncStatus: syncStatus,
                syncError: syncError,
                syncVersion: syncVersion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$WalksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({walkPointsRefs = false, walkPausesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (walkPointsRefs) db.walkPoints,
                    if (walkPausesRefs) db.walkPauses,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (walkPointsRefs)
                        await $_getPrefetchedData<Walk, $WalksTable, WalkPoint>(
                          currentTable: table,
                          referencedTable: $$WalksTableReferences
                              ._walkPointsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WalksTableReferences(
                                db,
                                table,
                                p0,
                              ).walkPointsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.walkId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (walkPausesRefs)
                        await $_getPrefetchedData<Walk, $WalksTable, WalkPause>(
                          currentTable: table,
                          referencedTable: $$WalksTableReferences
                              ._walkPausesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WalksTableReferences(
                                db,
                                table,
                                p0,
                              ).walkPausesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.walkId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WalksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalksTable,
      Walk,
      $$WalksTableFilterComposer,
      $$WalksTableOrderingComposer,
      $$WalksTableAnnotationComposer,
      $$WalksTableCreateCompanionBuilder,
      $$WalksTableUpdateCompanionBuilder,
      (Walk, $$WalksTableReferences),
      Walk,
      PrefetchHooks Function({bool walkPointsRefs, bool walkPausesRefs})
    >;
typedef $$WalkPointsTableCreateCompanionBuilder =
    WalkPointsCompanion Function({
      Value<int> id,
      required String walkId,
      required int recordedAt,
      required double lat,
      required double lng,
      Value<double?> altitude,
      Value<double?> accuracy,
      Value<double?> speed,
      Value<double?> bearing,
      Value<bool> isFiltered,
    });
typedef $$WalkPointsTableUpdateCompanionBuilder =
    WalkPointsCompanion Function({
      Value<int> id,
      Value<String> walkId,
      Value<int> recordedAt,
      Value<double> lat,
      Value<double> lng,
      Value<double?> altitude,
      Value<double?> accuracy,
      Value<double?> speed,
      Value<double?> bearing,
      Value<bool> isFiltered,
    });

final class $$WalkPointsTableReferences
    extends BaseReferences<_$AppDatabase, $WalkPointsTable, WalkPoint> {
  $$WalkPointsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WalksTable _walkIdTable(_$AppDatabase db) => db.walks.createAlias(
    $_aliasNameGenerator(db.walkPoints.walkId, db.walks.id),
  );

  $$WalksTableProcessedTableManager get walkId {
    final $_column = $_itemColumn<String>('walk_id')!;

    final manager = $$WalksTableTableManager(
      $_db,
      $_db.walks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_walkIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WalkPointsTableFilterComposer
    extends Composer<_$AppDatabase, $WalkPointsTable> {
  $$WalkPointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get altitude => $composableBuilder(
    column: $table.altitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bearing => $composableBuilder(
    column: $table.bearing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFiltered => $composableBuilder(
    column: $table.isFiltered,
    builder: (column) => ColumnFilters(column),
  );

  $$WalksTableFilterComposer get walkId {
    final $$WalksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walkId,
      referencedTable: $db.walks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalksTableFilterComposer(
            $db: $db,
            $table: $db.walks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WalkPointsTableOrderingComposer
    extends Composer<_$AppDatabase, $WalkPointsTable> {
  $$WalkPointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get altitude => $composableBuilder(
    column: $table.altitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bearing => $composableBuilder(
    column: $table.bearing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFiltered => $composableBuilder(
    column: $table.isFiltered,
    builder: (column) => ColumnOrderings(column),
  );

  $$WalksTableOrderingComposer get walkId {
    final $$WalksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walkId,
      referencedTable: $db.walks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalksTableOrderingComposer(
            $db: $db,
            $table: $db.walks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WalkPointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalkPointsTable> {
  $$WalkPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => column);

  GeneratedColumn<double> get altitude =>
      $composableBuilder(column: $table.altitude, builder: (column) => column);

  GeneratedColumn<double> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<double> get speed =>
      $composableBuilder(column: $table.speed, builder: (column) => column);

  GeneratedColumn<double> get bearing =>
      $composableBuilder(column: $table.bearing, builder: (column) => column);

  GeneratedColumn<bool> get isFiltered => $composableBuilder(
    column: $table.isFiltered,
    builder: (column) => column,
  );

  $$WalksTableAnnotationComposer get walkId {
    final $$WalksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walkId,
      referencedTable: $db.walks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalksTableAnnotationComposer(
            $db: $db,
            $table: $db.walks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WalkPointsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalkPointsTable,
          WalkPoint,
          $$WalkPointsTableFilterComposer,
          $$WalkPointsTableOrderingComposer,
          $$WalkPointsTableAnnotationComposer,
          $$WalkPointsTableCreateCompanionBuilder,
          $$WalkPointsTableUpdateCompanionBuilder,
          (WalkPoint, $$WalkPointsTableReferences),
          WalkPoint,
          PrefetchHooks Function({bool walkId})
        > {
  $$WalkPointsTableTableManager(_$AppDatabase db, $WalkPointsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalkPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalkPointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalkPointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> walkId = const Value.absent(),
                Value<int> recordedAt = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lng = const Value.absent(),
                Value<double?> altitude = const Value.absent(),
                Value<double?> accuracy = const Value.absent(),
                Value<double?> speed = const Value.absent(),
                Value<double?> bearing = const Value.absent(),
                Value<bool> isFiltered = const Value.absent(),
              }) => WalkPointsCompanion(
                id: id,
                walkId: walkId,
                recordedAt: recordedAt,
                lat: lat,
                lng: lng,
                altitude: altitude,
                accuracy: accuracy,
                speed: speed,
                bearing: bearing,
                isFiltered: isFiltered,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String walkId,
                required int recordedAt,
                required double lat,
                required double lng,
                Value<double?> altitude = const Value.absent(),
                Value<double?> accuracy = const Value.absent(),
                Value<double?> speed = const Value.absent(),
                Value<double?> bearing = const Value.absent(),
                Value<bool> isFiltered = const Value.absent(),
              }) => WalkPointsCompanion.insert(
                id: id,
                walkId: walkId,
                recordedAt: recordedAt,
                lat: lat,
                lng: lng,
                altitude: altitude,
                accuracy: accuracy,
                speed: speed,
                bearing: bearing,
                isFiltered: isFiltered,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WalkPointsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({walkId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (walkId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.walkId,
                                referencedTable: $$WalkPointsTableReferences
                                    ._walkIdTable(db),
                                referencedColumn: $$WalkPointsTableReferences
                                    ._walkIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WalkPointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalkPointsTable,
      WalkPoint,
      $$WalkPointsTableFilterComposer,
      $$WalkPointsTableOrderingComposer,
      $$WalkPointsTableAnnotationComposer,
      $$WalkPointsTableCreateCompanionBuilder,
      $$WalkPointsTableUpdateCompanionBuilder,
      (WalkPoint, $$WalkPointsTableReferences),
      WalkPoint,
      PrefetchHooks Function({bool walkId})
    >;
typedef $$WalkPausesTableCreateCompanionBuilder =
    WalkPausesCompanion Function({
      Value<int> id,
      required String walkId,
      required int pausedAt,
      Value<int?> resumedAt,
    });
typedef $$WalkPausesTableUpdateCompanionBuilder =
    WalkPausesCompanion Function({
      Value<int> id,
      Value<String> walkId,
      Value<int> pausedAt,
      Value<int?> resumedAt,
    });

final class $$WalkPausesTableReferences
    extends BaseReferences<_$AppDatabase, $WalkPausesTable, WalkPause> {
  $$WalkPausesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WalksTable _walkIdTable(_$AppDatabase db) => db.walks.createAlias(
    $_aliasNameGenerator(db.walkPauses.walkId, db.walks.id),
  );

  $$WalksTableProcessedTableManager get walkId {
    final $_column = $_itemColumn<String>('walk_id')!;

    final manager = $$WalksTableTableManager(
      $_db,
      $_db.walks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_walkIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WalkPausesTableFilterComposer
    extends Composer<_$AppDatabase, $WalkPausesTable> {
  $$WalkPausesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pausedAt => $composableBuilder(
    column: $table.pausedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get resumedAt => $composableBuilder(
    column: $table.resumedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WalksTableFilterComposer get walkId {
    final $$WalksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walkId,
      referencedTable: $db.walks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalksTableFilterComposer(
            $db: $db,
            $table: $db.walks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WalkPausesTableOrderingComposer
    extends Composer<_$AppDatabase, $WalkPausesTable> {
  $$WalkPausesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pausedAt => $composableBuilder(
    column: $table.pausedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get resumedAt => $composableBuilder(
    column: $table.resumedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WalksTableOrderingComposer get walkId {
    final $$WalksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walkId,
      referencedTable: $db.walks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalksTableOrderingComposer(
            $db: $db,
            $table: $db.walks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WalkPausesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalkPausesTable> {
  $$WalkPausesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pausedAt =>
      $composableBuilder(column: $table.pausedAt, builder: (column) => column);

  GeneratedColumn<int> get resumedAt =>
      $composableBuilder(column: $table.resumedAt, builder: (column) => column);

  $$WalksTableAnnotationComposer get walkId {
    final $$WalksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walkId,
      referencedTable: $db.walks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalksTableAnnotationComposer(
            $db: $db,
            $table: $db.walks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WalkPausesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalkPausesTable,
          WalkPause,
          $$WalkPausesTableFilterComposer,
          $$WalkPausesTableOrderingComposer,
          $$WalkPausesTableAnnotationComposer,
          $$WalkPausesTableCreateCompanionBuilder,
          $$WalkPausesTableUpdateCompanionBuilder,
          (WalkPause, $$WalkPausesTableReferences),
          WalkPause,
          PrefetchHooks Function({bool walkId})
        > {
  $$WalkPausesTableTableManager(_$AppDatabase db, $WalkPausesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalkPausesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalkPausesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalkPausesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> walkId = const Value.absent(),
                Value<int> pausedAt = const Value.absent(),
                Value<int?> resumedAt = const Value.absent(),
              }) => WalkPausesCompanion(
                id: id,
                walkId: walkId,
                pausedAt: pausedAt,
                resumedAt: resumedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String walkId,
                required int pausedAt,
                Value<int?> resumedAt = const Value.absent(),
              }) => WalkPausesCompanion.insert(
                id: id,
                walkId: walkId,
                pausedAt: pausedAt,
                resumedAt: resumedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WalkPausesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({walkId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (walkId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.walkId,
                                referencedTable: $$WalkPausesTableReferences
                                    ._walkIdTable(db),
                                referencedColumn: $$WalkPausesTableReferences
                                    ._walkIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WalkPausesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalkPausesTable,
      WalkPause,
      $$WalkPausesTableFilterComposer,
      $$WalkPausesTableOrderingComposer,
      $$WalkPausesTableAnnotationComposer,
      $$WalkPausesTableCreateCompanionBuilder,
      $$WalkPausesTableUpdateCompanionBuilder,
      (WalkPause, $$WalkPausesTableReferences),
      WalkPause,
      PrefetchHooks Function({bool walkId})
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      required String entityType,
      required String entityId,
      required String operation,
      Value<String?> payloadJson,
      Value<int> attempts,
      Value<int> nextAttemptAt,
      required int createdAt,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> operation,
      Value<String?> payloadJson,
      Value<int> attempts,
      Value<int> nextAttemptAt,
      Value<int> createdAt,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<int> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String?> payloadJson = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<int> nextAttemptAt = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payloadJson: payloadJson,
                attempts: attempts,
                nextAttemptAt: nextAttemptAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityType,
                required String entityId,
                required String operation,
                Value<String?> payloadJson = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<int> nextAttemptAt = const Value.absent(),
                required int createdAt,
              }) => SyncQueueCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payloadJson: payloadJson,
                attempts: attempts,
                nextAttemptAt: nextAttemptAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WalksTableTableManager get walks =>
      $$WalksTableTableManager(_db, _db.walks);
  $$WalkPointsTableTableManager get walkPoints =>
      $$WalkPointsTableTableManager(_db, _db.walkPoints);
  $$WalkPausesTableTableManager get walkPauses =>
      $$WalkPausesTableTableManager(_db, _db.walkPauses);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}

mixin _$WalksDaoMixin on DatabaseAccessor<AppDatabase> {
  $WalksTable get walks => attachedDatabase.walks;
}
mixin _$WalkPointsDaoMixin on DatabaseAccessor<AppDatabase> {
  $WalksTable get walks => attachedDatabase.walks;
  $WalkPointsTable get walkPoints => attachedDatabase.walkPoints;
}
mixin _$WalkPausesDaoMixin on DatabaseAccessor<AppDatabase> {
  $WalksTable get walks => attachedDatabase.walks;
  $WalkPausesTable get walkPauses => attachedDatabase.walkPauses;
}
mixin _$SyncQueueDaoMixin on DatabaseAccessor<AppDatabase> {
  $SyncQueueTable get syncQueue => attachedDatabase.syncQueue;
}
mixin _$AppSettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AppSettingsTable get appSettings => attachedDatabase.appSettings;
}
