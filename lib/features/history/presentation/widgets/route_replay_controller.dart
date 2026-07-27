import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';

class RouteReplayController extends ChangeNotifier {
  RouteReplayController({
    required this.points,
    this.duration = const Duration(seconds: 30),
  }) : _accepted = points.where((p) => !p.isFiltered).toList();

  final List<GeoPoint> points;
  final Duration duration;
  final List<GeoPoint> _accepted;

  Timer? _timer;
  int _index = 0;
  bool _playing = false;
  double _progress = 0;

  bool get isPlaying => _playing;
  double get progress => _progress;
  GeoPoint? get currentPoint =>
      _accepted.isEmpty ? null : _accepted[_index.clamp(0, _accepted.length - 1)];

  List<LatLng> get polylinePoints => _accepted
      .take(_index + 1)
      .map((p) => LatLng(p.latitude, p.longitude))
      .toList();

  void play() {
    if (_accepted.length < 2) return;
    _playing = true;
    final stepMs = duration.inMilliseconds ~/ (_accepted.length - 1);
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: stepMs.clamp(16, 500)), (_) {
      if (_index >= _accepted.length - 1) {
        pause();
        return;
      }
      _index++;
      _progress = _index / (_accepted.length - 1);
      notifyListeners();
    });
    notifyListeners();
  }

  void pause() {
    _playing = false;
    _timer?.cancel();
    notifyListeners();
  }

  void reset() {
    pause();
    _index = 0;
    _progress = 0;
    notifyListeners();
  }

  void seek(double value) {
    if (_accepted.isEmpty) return;
    _index = (value * (_accepted.length - 1)).round();
    _progress = value.clamp(0.0, 1.0);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
