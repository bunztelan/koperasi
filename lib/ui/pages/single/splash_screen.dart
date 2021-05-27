import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:k2ms_v2/blocs/sign_in/sign_in_local.dart';
import 'package:k2ms_v2/config/color_config.dart';
import 'package:k2ms_v2/config/route/route_name.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Navigate to to main screen
  Future _toMain() async {
    await Firebase.initializeApp();
    var getUserLocalData = await LocalData.getUserLocalData();

    return Timer(Duration(seconds: 3), () async {
      if (getUserLocalData != null) {
        Beamer.of(context).beamToNamed('/${RouteName.userDashboard}');
      } else {
        Beamer.of(context).beamToNamed('${RouteName.authSignIn}');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _toMain();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    );

    return Scaffold(
      body: Container(
        color: AppColor.primaryColor,
        child: Center(
          child: Text(
            'Koperasi',
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
