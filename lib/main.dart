import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:k2ms_v2/config/route/dashboard_location.dart';
import 'package:k2ms_v2/config/route/general_location.dart';
import 'package:k2ms_v2/ui/pages/single/splash_screen.dart';

import 'ui/pages/order/checkout_page.dart';
import 'ui/pages/pages.dart';
import 'ui/pages/single/confirmation_mail_page.dart';
import 'ui/pages/single/order_made_page.dart';
import 'ui/pages/single/signup_complete_page.dart';

import 'config/route/route_name.dart';
import 'config/theme_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        GeneralLocation(),
        DashboardLocation(),
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
        backButtonDispatcher:
            BeamerBackButtonDispatcher(delegate: _routerDelegate),
      ),
    );
  }
}
