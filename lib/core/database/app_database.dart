import 'dart:convert';

import 'package:drift/drift.dart';

part 'app_database.g.dart';

class Walks extends Table {
  TextColumn get id => text()();
  TextColumn get remoteId => text().nullable()();
  TextColumn get userId => text()();
  TextColumn get title => text().nullable()();
  TextColumn get status => text()();
  IntColumn get startedAt => integer()();
  IntColumn get endedAt => integer().nullable()();
  IntColumn get durationMs => integer().withDefault(const Constant(0))();
  IntColumn get pausedDurationMs => integer().withDefault(const Constant(0))();
  RealColumn get distanceMeters => real().withDefault(const Constant(0))();
  RealColumn get avgPaceSecPerKm => real().withDefault(const Constant(0))();
  RealColumn get avgSpeedMps => real().withDefault(const Constant(0))();
  RealColumn get maxSpeedMps => real().withDefault(const Constant(0))();
  RealColumn get caloriesKcal => real().withDefault(const Constant(0))();
  IntColumn get steps => integer().withDefault(const Constant(0))();
  RealColumn get elevationGainM => real().withDefault(const Constant(0))();
  RealColumn get elevationLossM => real().withDefault(const Constant(0))();
  RealColumn get startLat => real().nullable()();
  RealColumn get startLng => real().nullable()();
  RealColumn get endLat => real().nullable()();
  RealColumn get endLng => real().nullable()();
  TextColumn get boundsJson => text().nullable()();
  TextColumn get polylineEncoded => text().nullable()();
  IntColumn get pointCount => integer().withDefault(const Constant(0))();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get syncError => text().nullable()();
  IntColumn get syncVersion => integer().withDefault(const Constant(0))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class WalkPoints extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get walkId => text().references(Walks, #id, onDelete: KeyAction.cascade)();
  IntColumn get recordedAt => integer()();
  RealColumn get lat => real()();
  RealColumn get lng => real()();
  RealColumn get altitude => real().nullable()();
  RealColumn get accuracy => real().nullable()();
  RealColumn get speed => real().nullable()();
  RealColumn get bearing => real().nullable()();
  BoolColumn get isFiltered => boolean().withDefault(const Constant(false))();
}

class WalkPauses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get walkId => text().references(Walks, #id, onDelete: KeyAction.cascade)();
  IntColumn get pausedAt => integer()();
  IntColumn get resumedAt => integer().nullable()();
}

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get operation => text()();
  TextColumn get payloadJson => text().nullable()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  IntColumn get nextAttemptAt => integer().withDefault(const Constant(0))();
  IntColumn get createdAt => integer()();
}

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

@DriftDatabase(
  tables: [Walks, WalkPoints, WalkPauses, SyncQueue, AppSettings],
  daos: [WalksDao, WalkPointsDao, WalkPausesDao, SyncQueueDao, AppSettingsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_walk_points_walk_recorded '
            'ON walk_points (walk_id, recorded_at)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_walks_user_started '
            'ON walks (user_id, started_at DESC)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_sync_queue_next_attempt '
            'ON sync_queue (next_attempt_at ASC)',
          );
        },
      );
}

@DriftAccessor(tables: [Walks])
class WalksDao extends DatabaseAccessor<AppDatabase> with _$WalksDaoMixin {
  WalksDao(super.db);

  Future<Walk?> getActiveWalk() {
    return (select(walks)
          ..where(
            (w) => w.status.isIn(['in_progress', 'paused']),
          )
          ..orderBy([(w) => OrderingTerm.desc(w.startedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<Walk?> getWalkById(String id) {
    return (select(walks)..where((w) => w.id.equals(id))).getSingleOrNull();
  }

  Future<List<Walk>> getWalksByUser(
    String userId, {
    int? limit,
    int? offset,
  }) {
    final query = select(walks)
      ..where((w) => w.userId.equals(userId))
      ..orderBy([(w) => OrderingTerm.desc(w.startedAt)]);
    if (limit != null) {
      query.limit(limit, offset: offset ?? 0);
    }
    return query.get();
  }

  Stream<List<Walk>> watchWalksByUser(String userId, {int? limit}) {
    final query = select(walks)
      ..where((w) => w.userId.equals(userId))
      ..orderBy([(w) => OrderingTerm.desc(w.startedAt)]);
    if (limit != null) {
      query.limit(limit);
    }
    return query.watch();
  }

  Future<List<Walk>> getWalksPendingSync() {
    return (select(walks)
          ..where((w) => w.syncStatus.isIn(['pending', 'error']))
          ..orderBy([(w) => OrderingTerm.asc(w.updatedAt)]))
        .get();
  }

  Future<int> insertWalk(WalksCompanion walk) => into(walks).insert(walk);

  Future<bool> updateWalk(WalksCompanion walk) => update(walks).replace(walk);

  Future<int> upsertWalk(WalksCompanion walk) {
    return into(walks).insertOnConflictUpdate(walk);
  }

  Future<int> deleteWalk(String id) {
    return (delete(walks)..where((w) => w.id.equals(id))).go();
  }

  Stream<Walk?> watchActiveWalk() {
    return (select(walks)
          ..where(
            (w) => w.status.isIn(['in_progress', 'paused']),
          )
          ..orderBy([(w) => OrderingTerm.desc(w.startedAt)])
          ..limit(1))
        .watchSingleOrNull();
  }
}

@DriftAccessor(tables: [WalkPoints])
class WalkPointsDao extends DatabaseAccessor<AppDatabase>
    with _$WalkPointsDaoMixin {
  WalkPointsDao(super.db);

  Future<List<WalkPoint>> getPointsForWalk(
    String walkId, {
    bool includeFiltered = true,
  }) {
    final query = select(walkPoints)
      ..where((p) => p.walkId.equals(walkId))
      ..orderBy([(p) => OrderingTerm.asc(p.recordedAt)]);
    if (!includeFiltered) {
      query.where((p) => p.isFiltered.equals(false));
    }
    return query.get();
  }

  Stream<List<WalkPoint>> watchPointsForWalk(String walkId) {
    return (select(walkPoints)
          ..where((p) => p.walkId.equals(walkId))
          ..orderBy([(p) => OrderingTerm.asc(p.recordedAt)]))
        .watch();
  }

  Future<int> insertPoint(WalkPointsCompanion point) {
    return into(walkPoints).insert(point);
  }

  Future<void> insertPoints(List<WalkPointsCompanion> points) async {
    await batch((b) {
      b.insertAll(walkPoints, points);
    });
  }

  Future<int> deletePointsForWalk(String walkId) {
    return (delete(walkPoints)..where((p) => p.walkId.equals(walkId))).go();
  }

  Future<int> countPointsForWalk(String walkId) async {
    final countExp = walkPoints.id.count();
    final query = selectOnly(walkPoints)
      ..addColumns([countExp])
      ..where(walkPoints.walkId.equals(walkId));
    final row = await query.getSingle();
    return row.read(countExp) ?? 0;
  }
}

@DriftAccessor(tables: [WalkPauses])
class WalkPausesDao extends DatabaseAccessor<AppDatabase>
    with _$WalkPausesDaoMixin {
  WalkPausesDao(super.db);

  Future<List<WalkPause>> getPausesForWalk(String walkId) {
    return (select(walkPauses)
          ..where((p) => p.walkId.equals(walkId))
          ..orderBy([(p) => OrderingTerm.asc(p.pausedAt)]))
        .get();
  }

  Future<WalkPause?> getOpenPause(String walkId) {
    return (select(walkPauses)
          ..where((p) => p.walkId.equals(walkId) & p.resumedAt.isNull())
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int> insertPause(WalkPausesCompanion pause) {
    return into(walkPauses).insert(pause);
  }

  Future<int> updatePause(WalkPausesCompanion pause) {
    return (update(walkPauses)..where((p) => p.id.equals(pause.id.value)))
        .write(pause);
  }
}

@DriftAccessor(tables: [SyncQueue])
class SyncQueueDao extends DatabaseAccessor<AppDatabase>
    with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);

  Future<List<SyncQueueData>> getPendingItems({int limit = 20}) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return (select(syncQueue)
          ..where((q) => q.nextAttemptAt.isSmallerOrEqualValue(now))
          ..orderBy([(q) => OrderingTerm.asc(q.nextAttemptAt)])
          ..limit(limit))
        .get();
  }

  Future<int> enqueue(SyncQueueCompanion item) {
    return into(syncQueue).insert(item);
  }

  Future<int> deleteItem(int id) {
    return (delete(syncQueue)..where((q) => q.id.equals(id))).go();
  }

  Future<int> markAttempt(
    int id, {
    required int attempts,
    required int nextAttemptAt,
  }) {
    return (update(syncQueue)..where((q) => q.id.equals(id))).write(
      SyncQueueCompanion(
        attempts: Value(attempts),
        nextAttemptAt: Value(nextAttemptAt),
      ),
    );
  }

  Future<int> pendingCount() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final countExp = syncQueue.id.count();
    final query = selectOnly(syncQueue)
      ..addColumns([countExp])
      ..where(syncQueue.nextAttemptAt.isSmallerOrEqualValue(now));
    final row = await query.getSingle();
    return row.read(countExp) ?? 0;
  }
}

@DriftAccessor(tables: [AppSettings])
class AppSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$AppSettingsDaoMixin {
  AppSettingsDao(super.db);

  Future<String?> getValue(String key) async {
    final row = await (select(appSettings)..where((s) => s.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> setValue(String key, String value) {
    return into(appSettings).insertOnConflictUpdate(
      AppSettingsCompanion(
        key: Value(key),
        value: Value(value),
      ),
    );
  }

  Future<Map<String, String>> getAll() async {
    final rows = await select(appSettings).get();
    return {for (final row in rows) row.key: row.value};
  }
}

/// Helpers for encoding/decoding bounds JSON stored on walks.
class WalkBounds {
  const WalkBounds({
    required this.minLat,
    required this.maxLat,
    required this.minLng,
    required this.maxLng,
  });

  final double minLat;
  final double maxLat;
  final double minLng;
  final double maxLng;

  Map<String, dynamic> toJson() => {
        'minLat': minLat,
        'maxLat': maxLat,
        'minLng': minLng,
        'maxLng': maxLng,
      };

  factory WalkBounds.fromJson(Map<String, dynamic> json) {
    return WalkBounds(
      minLat: (json['minLat'] as num).toDouble(),
      maxLat: (json['maxLat'] as num).toDouble(),
      minLng: (json['minLng'] as num).toDouble(),
      maxLng: (json['maxLng'] as num).toDouble(),
    );
  }

  static WalkBounds? decode(String? jsonStr) {
    if (jsonStr == null || jsonStr.isEmpty) return null;
    return WalkBounds.fromJson(jsonDecode(jsonStr) as Map<String, dynamic>);
  }

  static String encode(WalkBounds bounds) => jsonEncode(bounds.toJson());
}
