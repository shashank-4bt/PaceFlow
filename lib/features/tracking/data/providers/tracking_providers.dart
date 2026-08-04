import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paceflow/core/database/database_provider.dart';
import 'package:paceflow/features/tracking/data/datasources/walk_local_datasource.dart';
import 'package:paceflow/features/tracking/data/datasources/walk_remote_datasource.dart';
import 'package:paceflow/features/tracking/data/repositories/tracking_repository_impl.dart';
import 'package:paceflow/features/tracking/data/services/sync_engine.dart';
import 'package:paceflow/features/tracking/domain/repositories/tracking_repository.dart';
import 'package:paceflow/features/tracking/domain/usecases/discard_walk.dart';
import 'package:paceflow/features/tracking/domain/usecases/pause_walk.dart';
import 'package:paceflow/features/tracking/domain/usecases/recover_walk.dart';
import 'package:paceflow/features/tracking/domain/usecases/resume_walk.dart';
import 'package:paceflow/features/tracking/domain/usecases/start_walk.dart';
import 'package:paceflow/features/tracking/domain/usecases/stop_walk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final walkLocalDataSourceProvider = Provider<WalkLocalDataSource>((ref) {
  return WalkLocalDataSource(ref.watch(appDatabaseProvider));
});

final walkRemoteDataSourceProvider = Provider<WalkRemoteDataSource>((ref) {
  return WalkRemoteDataSource(FirebaseFirestore.instance);
});

final trackingRepositoryImplProvider = Provider<TrackingRepositoryImpl>((ref) {
  return TrackingRepositoryImpl(
    local: ref.watch(walkLocalDataSourceProvider),
    remote: ref.watch(walkRemoteDataSourceProvider),
  );
});

final trackingRepositoryProvider = Provider<TrackingRepository>((ref) {
  return ref.watch(trackingRepositoryImplProvider);
});

final syncEngineProvider = Provider<SyncEngine>((ref) {
  final engine = SyncEngine(
    local: ref.watch(walkLocalDataSourceProvider),
    repository: ref.watch(trackingRepositoryImplProvider),
  );
  ref.onDispose(engine.stop);
  return engine;
});

final startWalkUseCaseProvider = Provider<StartWalkUseCase>((ref) {
  return StartWalkUseCase(ref.watch(trackingRepositoryProvider));
});

final pauseWalkUseCaseProvider = Provider<PauseWalkUseCase>((ref) {
  return PauseWalkUseCase(ref.watch(trackingRepositoryProvider));
});

final resumeWalkUseCaseProvider = Provider<ResumeWalkUseCase>((ref) {
  return ResumeWalkUseCase(ref.watch(trackingRepositoryProvider));
});

final stopWalkUseCaseProvider = Provider<StopWalkUseCase>((ref) {
  return StopWalkUseCase(ref.watch(trackingRepositoryProvider));
});

final discardWalkUseCaseProvider = Provider<DiscardWalkUseCase>((ref) {
  return DiscardWalkUseCase(ref.watch(trackingRepositoryProvider));
});

final recoverWalkUseCaseProvider = Provider<RecoverWalkUseCase>((ref) {
  return RecoverWalkUseCase(ref.watch(trackingRepositoryProvider));
});
