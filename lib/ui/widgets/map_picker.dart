import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

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

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
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
                widget.onLatLongChange(position.target.latitude.toString(),
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
}
