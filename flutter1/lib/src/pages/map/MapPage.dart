import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/src/app.dart';
import 'package:flutter1/src/constants/asset.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as maptoolkit;


import '../../services/common.dart';
import '../../widgets/custom_flushbar.dart';

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
    // testMarker();
    _buildPolygon();
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

  _buildSingleMarker({required LatLng position}) async {
    await _addMarker(position);
    setState(() {
    });
  }

  _buildPolygon() {
    final polygon = Polygon(
      polygonId: PolygonId("1"),
      consumeTapEvents: true,
      onTap: (){
        final _mapToolkitLatLng = _dummyLatLng.map((e) {
          return maptoolkit.LatLng(e.latitude, e.longitude);
        }).toList();

        final meterArea = maptoolkit.SphericalUtil.computeArea(_mapToolkitLatLng);
        final kmArea = formatCurrency.format(meterArea/(1000*2));
        CustomFlushbar.showSuccess(navigatorState.currentContext!, message: "Area: $kmArea ²Km");
      },
      points: _dummyLatLng,
      strokeWidth: 2,
      strokeColor: Colors.yellow,
      fillColor: Colors.yellow.withOpacity(0.15),
    );

    _polygons.add(polygon);
    setState(() {});
  }


  // begin1
  String formatPosition(LatLng pos) {
    final lat = formatCurrency.format(pos.latitude);
    final lng = formatCurrency.format(pos.longitude);
    return "Pos: $lat, $lng";
  }

  void _launchMaps({required double lat, required double lng}) async {
    final parameter = '?z=16&q=$lat,$lng';

    if (Platform.isIOS) {
      final googleMap = Uri.parse('comgooglemaps://' + parameter);
      final appleMap = Uri.parse('https://maps.apple.com/' + parameter);
      if (await canLaunchUrl(googleMap)) {
        await launchUrl(googleMap);
        return;
      }
      if (await canLaunchUrl(appleMap)) {
        await launchUrl(appleMap);
        return;
      }
    } else {
      final googleMapURL = Uri.parse('https://maps.google.com/' + parameter);
      if (await canLaunchUrl(googleMapURL)) {
        await launchUrl(googleMapURL);
        return;
      }
    }
    throw 'Could not launch url';
  }


  Future<void> _addMarker(LatLng position) async {
    final Uint8List markerIcon = await getBytesFromAsset(Asset.pinBikerImage, width: 150);
    final BitmapDescriptor bitmap = BitmapDescriptor.fromBytes(markerIcon);

    _markers.add(
      Marker(
        // important. unique id
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(
          title: formatPosition(position),
          snippet: "",
          onTap: () => _launchMaps(lat: position.latitude, lng: position.longitude),
        ),
        icon: bitmap,
        onTap: () async {
          //todo
        },
      ),
    );
  }


  Future<void> _dummyLocation() async {
    await Future.delayed(Duration(seconds: 2));

    for (var latLng in _dummyLatLng) {
      await _addMarker(latLng);
    }

    _controller.future.then(
      (controller) => controller.moveCamera(
        CameraUpdate.newLatLngBounds(
          _boundsFromLatLngList(_dummyLatLng),
          100,
        ),
      ),
    );
    setState(() {});
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1 = 0;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }

  // end1

  Future<void> testMarker() async {
    final Uint8List markerIcon = await getBytesFromAsset(Asset.pinBikerImage, width: 150);
    final BitmapDescriptor bitmap = BitmapDescriptor.fromBytes(markerIcon);

    _markers.add(
      Marker(
        // important. unique id
        icon: bitmap,
        markerId: MarkerId("0010"),
        position: _initMap.target,
      ),
    );

    setState(() {});
  }
}
