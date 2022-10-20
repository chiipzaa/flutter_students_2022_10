import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter1/src/constants/asset.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const CameraPosition _initMap = CameraPosition(
    target: LatLng(13.7462463, 100.5325515),
    zoom: 20,
  );

  final Completer<GoogleMapController> _controller = Completer();
  StreamSubscription<LocationData>? _locationSubscription;
  final _locationService = Location();
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = {};

  final List<LatLng> _dummyLatLng = [
    LatLng(13.729336912458525, 100.57422749698162),
    LatLng(13.724325366482798, 100.58511726558208),
    LatLng(13.716931129483003, 100.57489234954119),
    LatLng(13.724794053328308, 100.56783076375723),
  ];

  @override
  void initState() {
    testMarket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MapPage'),
        ),
        body: Column(
          children: [
            Header(),
            Expanded(
              child: GoogleMap(
                onTap: (latLng) => _buildSingleMarker(position: latLng),
                markers: _markers,
                polygons: _polygons,
                // line, vector, polygon
                mapType: MapType.hybrid,
                initialCameraPosition: _initMap,
                onMapCreated: (controller) {
                  _controller.complete(controller);
                  _dummyLocation();
                },
              ),
            )
          ],
        ));
  }

  Header() {
    return Container(
        color: Colors.black87,
        child: Image.asset(
          Asset.logoImage,
          height: 100,
          width: double.infinity,
        ));
  }

  _buildSingleMarker({required LatLng position}) {}

  void _dummyLocation() {}

  void testMarket() {
    _markers.add(
      Marker(
        // important. unique id
        markerId: MarkerId("0010"),
        position: _initMap.target,
      ),
    );
  }
}
