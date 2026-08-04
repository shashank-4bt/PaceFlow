import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/native.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:paceflow/core/database/app_database.dart';
import 'package:paceflow/features/tracking/data/datasources/walk_local_datasource.dart';
import 'package:paceflow/features/tracking/data/datasources/walk_remote_datasource.dart';
import 'package:paceflow/features/tracking/data/repositories/tracking_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SyncEngine {
  SyncEngine({
    required WalkLocalDataSource local,
    required TrackingRepositoryImpl repository,
    Connectivity? connectivity,
  })  : _local = local,
        _repository = repository,
        _connectivity = connectivity ?? Connectivity();

  final WalkLocalDataSource _local;
  final TrackingRepositoryImpl _repository;
  final Connectivity _connectivity;
  final _log = Logger('SyncEngine');

  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isProcessing = false;

  Future<void> start() async {
    await _subscription?.cancel();
    _subscription = _connectivity.onConnectivityChanged.listen((_) {
      unawaited(processQueue());
    });
    await processQueue();
  }

  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  Future<void> processQueue() async {
    if (_isProcessing) return;
    if (!await _hasConnectivity()) return;

    _isProcessing = true;
    try {
      final items = await _local.getPendingSyncItems();
      for (final item in items) {
        try {
          if (item.entityType == 'walk' && item.operation == 'upsert') {
            await _repository.syncWalkToRemote(item.entityId);
          }
          await _local.removeSyncItem(item.id);
        } catch (error, stackTrace) {
          _log.warning('Sync failed for ${item.entityId}', error, stackTrace);
          final attempts = item.attempts + 1;
          final delayMinutes = attempts.clamp(1, 6) * 2;
          await _local.markSyncAttempt(
            item.id,
            attempts: attempts,
            nextAttemptAt: DateTime.now().add(Duration(minutes: delayMinutes)),
          );
        }
      }
    } finally {
      _isProcessing = false;
    }
  }

  Future<bool> _hasConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    return results.any((r) => r != ConnectivityResult.none);
  }
}

/// Standalone factory for background isolates where Riverpod is unavailable.
Future<SyncEngine> createSyncEngine() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File(p.join(dir.path, 'paceflow.db'));
  final db = AppDatabase(NativeDatabase(file));
  final local = WalkLocalDataSource(db);
  final remote = WalkRemoteDataSource(FirebaseFirestore.instance);
  final repository = TrackingRepositoryImpl(local: local, remote: remote);
  return SyncEngine(local: local, repository: repository);
}
