import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';

class RouteMap extends StatefulWidget {
  const RouteMap({
    super.key,
    required this.points,
    this.followUser = false,
  });

  final List<GeoPoint> points;
  final bool followUser;

  @override
  State<RouteMap> createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
  GoogleMapController? _controller;

  @override
  void didUpdateWidget(RouteMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.followUser && widget.points.isNotEmpty) {
      final last = widget.points.last;
      _controller?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(last.latitude, last.longitude),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final accepted = widget.points.where((p) => !p.isFiltered).toList();
    final polylinePoints = accepted
        .map((p) => LatLng(p.latitude, p.longitude))
        .toList();

    final initialPosition = accepted.isNotEmpty
        ? LatLng(accepted.first.latitude, accepted.first.longitude)
        : const LatLng(28.6139, 77.2090);

    final markers = <Marker>{};
    if (accepted.isNotEmpty) {
      markers.add(
        Marker(
          markerId: const MarkerId('start'),
          position: LatLng(accepted.first.latitude, accepted.first.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
      if (accepted.length > 1) {
        final end = accepted.last;
        markers.add(
          Marker(
            markerId: const MarkerId('end'),
            position: LatLng(end.latitude, end.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      }
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 16,
      ),
      onMapCreated: (controller) => _controller = controller,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      compassEnabled: false,
      mapToolbarEnabled: false,
      polylines: polylinePoints.length >= 2
          ? {
              Polyline(
                polylineId: const PolylineId('route'),
                points: polylinePoints,
                color: const Color(0xFF34D399),
                width: 5,
                jointType: JointType.round,
                startCap: Cap.roundCap,
                endCap: Cap.roundCap,
              ),
            }
          : {},
      markers: markers,
      style: _darkMapStyle,
    );
  }

  static const _darkMapStyle = '''
[
  {"elementType":"geometry","stylers":[{"color":"#1d2c4d"}]},
  {"elementType":"labels.text.fill","stylers":[{"color":"#8ec3b9"}]},
  {"elementType":"labels.text.stroke","stylers":[{"color":"#1a3646"}]},
  {"featureType":"road","elementType":"geometry","stylers":[{"color":"#304a7d"}]},
  {"featureType":"water","elementType":"geometry","stylers":[{"color":"#0e1626"}]}
]
''';
}
