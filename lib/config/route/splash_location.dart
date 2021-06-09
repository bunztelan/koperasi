import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/pages/single/splash_screen.dart';

class SplashlLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          child: SplashScreen(),
          key: ValueKey(RouteName.generalSplash),
        ),
      ];

  @override
  List<String> get pathBlueprints => [
        '/${RouteName.generalSplash}',
      ];
}
