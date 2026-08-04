import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';

class LocationPermissionException implements Exception {
  LocationPermissionException(this.message);

  final String message;

  @override
  String toString() => message;
}

class LocationDataSource {
  StreamSubscription<Position>? _subscription;
  final _controller = StreamController<GeoPoint>.broadcast();

  Stream<GeoPoint> get locationStream => _controller.stream;

  Future<bool> ensurePermissions() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationPermissionException('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw LocationPermissionException('Location permission denied.');
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionException(
        'Location permission permanently denied.',
      );
    }

    if (permission == LocationPermission.whileInUse) {
      final background = await Permission.locationAlways.request();
      if (!background.isGranted) {
        // Foreground tracking still works; background may be limited.
      }
    }

    return true;
  }

  Future<void> configureAndroidSettings() async {
    await Geolocator.openLocationSettings();
  }

  Future<GeoPoint?> getCurrentPosition() async {
    await ensurePermissions();
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      ),
    );
    return _mapPosition(position);
  }

  Future<void> startTracking({int distanceFilterMeters = 3}) async {
    await ensurePermissions();
    await stopTracking();

    final settings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: distanceFilterMeters,
    );

    _subscription = Geolocator.getPositionStream(locationSettings: settings)
        .listen(
      (position) {
        _controller.add(_mapPosition(position));
      },
      onError: _controller.addError,
    );
  }

  Future<void> stopTracking() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  GeoPoint _mapPosition(Position position) {
    return GeoPoint(
      latitude: position.latitude,
      longitude: position.longitude,
      recordedAt: position.timestamp,
      altitude: position.altitude,
      accuracy: position.accuracy,
      speed: position.speed >= 0 ? position.speed : null,
      bearing: position.heading >= 0 ? position.heading : null,
    );
  }

  Future<void> dispose() async {
    await stopTracking();
    await _controller.close();
  }
}
