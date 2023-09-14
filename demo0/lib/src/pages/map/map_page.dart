import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:demo0/src/app.dart';
import 'package:demo0/src/app.dart';
import 'package:demo0/src/bloc/map/map_bloc.dart';
import 'package:demo0/src/constants/asset.dart';
import 'package:demo0/src/services/common.dart';
import 'package:demo0/src/widgets/custom_flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as maptoolkit;
import 'package:url_launcher/url_launcher.dart';

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
    super.initState();
    _buildSingleMarker(position: LatLng(13.7462463, 100.5325515));
    _buildPolygon();
  }

  @override
  void dispose() {
    super.dispose();
    _stopTracking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _buildTrackingButton(),
        appBar: AppBar(
          title: Text('MapPage'),
          actions: [
            IconButton(
                onPressed: () {
                  _controller.future.then(
                    (value) => value.animateCamera(
                      CameraUpdate.newLatLngZoom(_initMap.target, 15),
                    ),
                  );
                },
                icon: Icon(Icons.pin_drop)),
            IconButton(
                onPressed: () async {
                  final controller = await _controller.future;
                  controller.animateCamera(CameraUpdate.newLatLngZoom(
                      LatLng(35.6585848, 139.742858), 15));
                },
                icon: Icon(Icons.pin_drop_outlined))
          ],
        ),
        body: Column(
          children: [
            Image.asset(Asset.logoImage),
            Expanded(
              child: GoogleMap(
                trafficEnabled: true,
                onMapCreated: (controller) {
                  _controller.complete(controller);
                },
                initialCameraPosition: _initMap,
                markers: _markers,
              ),
            )
          ],
        ));
  }

  _buildPolygon() {
    final polygon = Polygon(
      polygonId: const PolygonId("1"),
      consumeTapEvents: true,
      points: _dummyLatLng,
      strokeWidth: 2,
      onTap: () {
        final mapToolkitLatLng = _dummyLatLng.map((e) {
          return maptoolkit.LatLng(e.latitude, e.longitude);
        }).toList();

        // https://www.mapdevelopers.com/area_finder.php
        // https://www.inchcalculator.com/convert/square-meter-to-square-kilometer/
        final meterArea =
            maptoolkit.SphericalUtil.computeArea(mapToolkitLatLng);
        final kmArea = formatCurrency.format(meterArea / (1000000));
        CustomFlushbar.showSuccess(navigatorState.currentContext!,
            message: "Area: $kmArea ²Km");
      },
      strokeColor: Colors.yellow,
      fillColor: Colors.yellow.withOpacity(0.15),
    );

    _polygons.add(polygon);
    setState(() {});
  }

  Future<void> _dummyLocation() async {
    await Future.delayed(Duration(seconds: 2));

    for (var latLng in _dummyLatLng) {
      await _buildSingleMarker(position: latLng);
    }

    _controller.future.then(
      (controller) => controller.moveCamera(
        CameraUpdate.newLatLngBounds(_boundsFromLatLngList(_dummyLatLng), 50),
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

  Future<void> _buildSingleMarker({required LatLng position}) async {
    final Uint8List markerIcon = await getBytesFromAsset(
      Asset.pinBikerImage,
      width: 150,
    );

    logger.d(position.toString());
    final BitmapDescriptor bitmap = BitmapDescriptor.fromBytes(markerIcon);

    final marker = Marker(
      markerId: MarkerId(jsonEncode(position)),
      icon: bitmap,
      infoWindow: InfoWindow(
        title: formatPosition(position),
        snippet: "",
        onTap: () =>
            _launchMaps(lat: position.latitude, lng: position.longitude),
      ),
      position: position,
    );
    _markers.add(marker);
    setState(() {});
  }

  bool _stopTracking() {
    if (_locationSubscription != null) {
      _locationSubscription?.cancel();
      _locationSubscription = null;
      logger.d("Stop tracking...");
      return true;
    }
    return false;
  }

  void _trackingLocation() async {
    // Start / Stop tracking
    if (_stopTracking()) {
      _markers.clear();
      setState(() {});
      return;
    }

    try {
      // Check avaliablity and permission service
      final serviceEnabled = await checkServiceGPS(_locationService);
      if (!serviceEnabled) {
        throw PlatformException(code: 'SERVICE_STATUS_DENIED');
      }

      final permissionGranted = await checkPermission(_locationService);
      if (!permissionGranted) {
        throw PlatformException(code: 'PERMISSION_DENIED');
      }

      // condition to tracking
      await _locationService.changeSettings(
        accuracy: LocationAccuracy.high,
        interval: 100,
        distanceFilter: 15,
      ); // meters.

      _locationSubscription = _locationService.onLocationChanged.listen(
        (locationData) async {
          _markers.clear();
          final latLng =
              LatLng(locationData.latitude!, locationData.longitude!);
          await _buildSingleMarker(position: latLng);
          _animateCamera(latLng);
          setState(() {});

          // Send new location to server
          // context.read<MapBloc>().add(MapEventSubmitLocation(position: latLng));
        },
      );
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'PERMISSION_DENIED':
          //todo
          break;
        case 'SERVICE_STATUS_ERROR':
          //todo
          break;
        case 'SERVICE_STATUS_DENIED':
          //todo
          break;
        default:
        //todo
      }
    }
  }

  Future<void> _animateCamera(LatLng latLng) async {
    _controller.future.then((controller) {
      controller.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));
    });
  }

  Widget _buildTrackingButton() {
    final isTracking = _locationSubscription != null;
    // return Padding(
    //   padding: const EdgeInsets.only(right: 50.0),
    //   child: FloatingActionButton.extended(
    //     onPressed: _trackingLocation,
    //     label: BlocBuilder<MapBloc, MapState>(
    //       builder: (context, state) {
    //         return Text(isTracking
    //             ? 'Stop Tracking ${formatPosition(state.currentPosition)}'
    //             : 'Start Tracking');
    //       },
    //     ),
    //     backgroundColor: isTracking ? Colors.red : Colors.blue,
    //     icon: Icon(isTracking ? Icons.stop : Icons.play_arrow),
    //   ),
    // );
    return Text("1234");
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

  String formatPosition(LatLng pos) {
    final lat = formatCurrency.format(pos.latitude);
    final lng = formatCurrency.format(pos.longitude);
    return ": $lat, $lng";
  }
}
