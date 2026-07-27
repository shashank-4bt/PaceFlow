import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/features/history/presentation/widgets/route_replay_controller.dart';
import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';

class RouteReplayMap extends StatefulWidget {
  const RouteReplayMap({
    super.key,
    required this.points,
    required this.controller,
    this.mapStyle,
    this.mapType = MapType.normal,
  });

  final List<GeoPoint> points;
  final RouteReplayController controller;
  final String? mapStyle;
  final MapType mapType;

  @override
  State<RouteReplayMap> createState() => _RouteReplayMapState();
}

class _RouteReplayMapState extends State<RouteReplayMap> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onReplayUpdate);
  }

  @override
  void didUpdateWidget(RouteReplayMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onReplayUpdate);
      widget.controller.addListener(_onReplayUpdate);
    }
    if (oldWidget.mapStyle != widget.mapStyle) {
      setState(() {});
    }
    if (oldWidget.mapType != widget.mapType) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onReplayUpdate);
    super.dispose();
  }

  void _onReplayUpdate() {
    final point = widget.controller.currentPoint;
    if (point != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(LatLng(point.latitude, point.longitude)),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final accepted = widget.points.where((p) => !p.isFiltered).toList();
    final initial = accepted.isNotEmpty
        ? LatLng(accepted.first.latitude, accepted.first.longitude)
        : const LatLng(28.6139, 77.2090);

    final current = widget.controller.currentPoint;
    final markers = <Marker>{};
    if (current != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('replay'),
          position: LatLng(current.latitude, current.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(target: initial, zoom: 16),
      onMapCreated: (controller) {
        _mapController = controller;
      },
      style: widget.mapStyle,
      mapType: widget.mapType,
      polylines: {
        Polyline(
          polylineId: const PolylineId('full'),
          points: accepted
              .map((p) => LatLng(p.latitude, p.longitude))
              .toList(),
          color: AppColors.emerald.withValues(alpha: 0.35),
          width: 4,
        ),
        if (widget.controller.polylinePoints.length >= 2)
          Polyline(
            polylineId: const PolylineId('progress'),
            points: widget.controller.polylinePoints,
            color: AppColors.emerald,
            width: 5,
          ),
      },
      markers: markers,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      compassEnabled: false,
    );
  }
}
