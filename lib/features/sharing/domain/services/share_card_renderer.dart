import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import 'package:paceflow/features/sharing/domain/entities/share_card_config.dart';

class ShareCardRenderer {
  ShareCardRenderer({ScreenshotController? controller})
      : _controller = controller ?? ScreenshotController();

  final ScreenshotController _controller;

  ScreenshotController get controller => _controller;

  Future<Uint8List> capture({
    required Widget card,
    required ShareCardConfig config,
    double? devicePixelRatio,
  }) async {
    final ratio = devicePixelRatio ?? ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
    final pixelRatio = (config.size.width / 360) * ratio;

    return _controller.captureFromWidget(
      MediaQuery(
        data: MediaQueryData(
          size: Size(
            config.size.width.toDouble(),
            config.size.height.toDouble(),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: card,
        ),
      ),
      delay: const Duration(milliseconds: 50),
      pixelRatio: pixelRatio,
    );
  }
}
