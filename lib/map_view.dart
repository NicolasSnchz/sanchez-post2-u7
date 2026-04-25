import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_service.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;

  final Set<Marker> _markers = {};
  final Set<Circle> _geofences = {};

  StreamSubscription<Position>? _positionSub;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      final pos = await LocationService.getCurrentPosition();
      final latLng = LatLng(pos.latitude, pos.longitude);

      setState(() {
        _currentPosition = latLng;
        _markers.add(_buildMarker(latLng));
        _geofences.add(_buildGeofenceCircle(latLng, 200));
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(latLng, 16),
      );

      _positionSub = LocationService.getPositionStream().listen(_onPosition);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de ubicación: $e')),
      );
    }
  }

  void _onPosition(Position pos) {
    final latLng = LatLng(pos.latitude, pos.longitude);

    setState(() {
      _currentPosition = latLng;

      _markers
        ..removeWhere((marker) => marker.markerId.value == 'user')
        ..add(_buildMarker(latLng));
    });

    _mapController?.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  Marker _buildMarker(LatLng position) {
    return Marker(
      markerId: const MarkerId('user'),
      position: position,
      infoWindow: const InfoWindow(title: 'Mi posición actual'),
    );
  }

  Circle _buildGeofenceCircle(LatLng center, double radiusMeters) {
    return Circle(
      circleId: const CircleId('geofence_1'),
      center: center,
      radius: radiusMeters,
      fillColor: Colors.blue.withValues(alpha: 0.15),
      strokeColor: Colors.blue,
      strokeWidth: 2,
    );
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _currentPosition!,
          zoom: 16,
        ),
        markers: _markers,
        circles: _geofences,
        myLocationEnabled: false,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
      ),
    );
  }
}