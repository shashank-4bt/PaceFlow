import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'package:paceflow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:paceflow/features/sharing/domain/entities/share_card_config.dart';
import 'package:paceflow/features/sharing/domain/services/share_card_renderer.dart';
import 'package:paceflow/features/sharing/presentation/widgets/route_share_card.dart';
import 'package:paceflow/features/tracking/data/models/walk_dto.dart';

class ShareState {
  const ShareState({
    this.config = const ShareCardConfig(),
    this.isExporting = false,
    this.errorMessage,
    this.lastExportPath,
  });

  final ShareCardConfig config;
  final bool isExporting;
  final String? errorMessage;
  final String? lastExportPath;

  ShareState copyWith({
    ShareCardConfig? config,
    bool? isExporting,
    String? errorMessage,
    String? lastExportPath,
    bool clearError = false,
  }) {
    return ShareState(
      config: config ?? this.config,
      isExporting: isExporting ?? this.isExporting,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      lastExportPath: lastExportPath ?? this.lastExportPath,
    );
  }
}

class ShareController extends Notifier<ShareState> {
  final _renderer = ShareCardRenderer();

  @override
  ShareState build() => const ShareState();

  void setTheme(ShareCardTheme theme) {
    state = state.copyWith(
      config: state.config.copyWith(theme: theme),
    );
  }

  void setSize(ShareCardSize size) {
    state = state.copyWith(config: state.config.copyWith(size: size));
  }

  void setGradient(ShareGradientPreset gradient) {
    state = state.copyWith(
      config: state.config.copyWith(gradient: gradient),
    );
  }

  void toggleCalories(bool value) {
    state = state.copyWith(
      config: state.config.copyWith(showCalories: value),
    );
  }

  Future<Uint8List?> exportPng({
    required WalkDto walk,
    required bool useMiles,
  }) async {
    final user = ref.read(authControllerProvider).user;
    state = state.copyWith(isExporting: true, clearError: true);

    try {
      final card = RouteShareCard(
        walk: walk,
        config: state.config,
        displayName: user?.displayName ?? 'Walker',
        photoUrl: user?.photoUrl,
        useMiles: useMiles,
      );

      final bytes = await _renderer.capture(
        card: SizedBox(
          width: state.config.size.width.toDouble(),
          height: state.config.size.height.toDouble(),
          child: card,
        ),
        config: state.config,
      );

      state = state.copyWith(isExporting: false);
      return bytes;
    } catch (error) {
      state = state.copyWith(
        isExporting: false,
        errorMessage: error.toString(),
      );
      return null;
    }
  }

  Future<void> shareWalk({
    required WalkDto walk,
    required bool useMiles,
  }) async {
    final bytes = await exportPng(walk: walk, useMiles: useMiles);
    if (bytes == null) return;

    final file = XFile.fromData(
      bytes,
      mimeType: 'image/png',
      name: 'paceflow_${walk.id}.png',
    );

    await Share.shareXFiles(
      [file],
      text: 'My walk on PaceFlow — Every Step Has a Story.',
    );
  }
}

final shareControllerProvider =
    NotifierProvider<ShareController, ShareState>(ShareController.new);
