import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

import 'package:k2ms_v2/config/color_config.dart';

class MapPicker extends StatefulWidget {
  final Function(String, String) onLatLongChange;

  MapPicker({this.onLatLongChange});

  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  Completer<GoogleMapController> _controller = Completer();
  String post = '';
  Position _current;
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );

  Future<bool> _initData() async {
    _current = await _determinePosition();

    setState(() {
      _kGooglePlex = CameraPosition(
        target: LatLng(
          _current.latitude.toDouble(),
          _current.longitude.toDouble(),
        ),
        zoom: 14.4746,
      );
    });

    widget.onLatLongChange(
      _current.latitude.toString(),
      _current.longitude.toString(),
    );

    return true;
  }

  @override
  void initState() {
    super.initState();
    //_initData();
  }

  /// Set current position
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  GoogleMap(
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMove: (position) {
                      widget.onLatLongChange(
                          position.target.latitude.toString(),
                          position.target.longitude.toString());
                    },
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.location_pin,
                      size: 48,
                      color: AppColor.roseColor,
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pop(context);
              },
              isExtended: true,
              icon: Icon(
                Icons.location_pin,
                color: AppColor.textPrimaryColor,
              ),
              label: Text(
                'Pin lokasi',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: AppColor.textPrimaryColor),
              ),
              backgroundColor: AppColor.primaryColor,
            ),
          );
        }
        return Container();
      },
    );
  }
}
