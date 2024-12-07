import 'dart:async';

import 'package:custom_markers_tutorial/map/provider/async_custom_markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();
    final List<Circle> circles = [
      const Circle(
          circleId: CircleId('Current location'),
          center: LatLng(21.00126273562229, 105.83141060525638),
          radius: 5,
          strokeColor: Colors.red,
          zIndex: 1),
      Circle(
        circleId: const CircleId('Current radius'),
        center: const LatLng(21.00126273562229, 105.83141060525638),
        radius: 1000,
        strokeColor: Colors.blue.shade300.withOpacity(0.3),
        strokeWidth: 1,
        fillColor: Colors.blue.shade300.withOpacity(0.3),
      ),
    ];
    final markerListData = ref.watch(asyncCustomMarkersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Markers on Google map'),
      ),
      body: SafeArea(
          child: switch (markerListData) {
        AsyncData(:final value) => Stack(children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(
                target: LatLng(21.00126273562229, 105.83141060525638),
                zoom: 14.8,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set.from(value),
              circles: Set.from(circles),
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: FloatingActionButton(
                backgroundColor: Colors.pink,
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ]),
        AsyncError(:final error) => Center(
            child: Text(error.toString()),
          ),
        _ => Center(
            child: CircularProgressIndicator(),
          ),
      }),
    );
  }
}
