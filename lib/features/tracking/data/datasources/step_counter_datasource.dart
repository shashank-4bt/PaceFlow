import 'dart:async';

import 'package:pedometer/pedometer.dart';

class StepCounterDataSource {
  StreamSubscription<StepCount>? _stepSubscription;
  StreamSubscription<PedestrianStatus>? _statusSubscription;
  final _stepsController = StreamController<int>.broadcast();

  int _baselineSteps = 0;
  int? _latestDeviceSteps;
  bool _hasBaseline = false;

  Stream<int> get stepStream => _stepsController.stream;

  Future<void> start({int initialSteps = 0}) async {
    await stop();
    _baselineSteps = initialSteps;
    _hasBaseline = false;
    _latestDeviceSteps = null;

    _stepSubscription = Pedometer.stepCountStream.listen(
      (event) {
        _latestDeviceSteps = event.steps;
        if (!_hasBaseline) {
          _baselineSteps = event.steps - initialSteps;
          _hasBaseline = true;
        }
        final walkSteps = event.steps - _baselineSteps;
        _stepsController.add(walkSteps < 0 ? 0 : walkSteps);
      },
      onError: _stepsController.addError,
    );

    _statusSubscription = Pedometer.pedestrianStatusStream.listen(
      (_) {},
      onError: (_) {},
    );
  }

  Future<void> stop() async {
    await _stepSubscription?.cancel();
    await _statusSubscription?.cancel();
    _stepSubscription = null;
    _statusSubscription = null;
  }

  int get currentSteps {
    if (_latestDeviceSteps == null) return 0;
    final walkSteps = _latestDeviceSteps! - _baselineSteps;
    return walkSteps < 0 ? 0 : walkSteps;
  }

  Future<void> dispose() async {
    await stop();
    await _stepsController.close();
  }
}
