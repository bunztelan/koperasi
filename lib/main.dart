import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:k2ms_v2/config/route/general_location.dart';
import 'package:k2ms_v2/config/route/order_location.dart';
import 'package:k2ms_v2/config/route/product_location.dart';
import 'package:k2ms_v2/config/route/splash_location.dart';

import 'config/theme_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        SplashlLocation(),
        GeneralLocation(),
        ProductLocation(),
        OrderLocation(),
      ],
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BeamerProvider(
      routerDelegate: _routerDelegate,
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: defaultStyleConfig,
        routeInformationParser: BeamerParser(),
        routerDelegate: _routerDelegate,
      ),
    );
  }
}
