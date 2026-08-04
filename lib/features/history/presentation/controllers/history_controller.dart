import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paceflow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:paceflow/features/history/data/repositories/history_repository_impl.dart';
import 'package:paceflow/features/history/domain/repositories/history_repository.dart';
import 'package:paceflow/features/tracking/data/models/walk_dto.dart';

class HistoryState {
  const HistoryState({
    this.walks = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<WalkDto> walks;
  final bool isLoading;
  final String? errorMessage;

  HistoryState copyWith({
    List<WalkDto>? walks,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HistoryState(
      walks: walks ?? this.walks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class HistoryController extends Notifier<HistoryState> {
  HistoryRepository get _repository => ref.read(historyRepositoryProvider);

  @override
  HistoryState build() {
    Future.microtask(refresh);
    return const HistoryState(isLoading: true);
  }

  Future<void> refresh() async {
    final userId = ref.read(authControllerProvider).user?.uid;
    if (userId == null) {
      state = const HistoryState(walks: []);
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repository.syncFromRemote(userId);
      final walks = await _repository.getWalkHistory(userId);
      state = state.copyWith(walks: walks, isLoading: false);
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
    }
  }
}

final historyControllerProvider =
    NotifierProvider<HistoryController, HistoryState>(HistoryController.new);

final walkDetailProvider =
    FutureProvider.family<WalkDto?, String>((ref, walkId) async {
  final repository = ref.watch(historyRepositoryProvider);
  return repository.getWalkDetail(walkId);
});
