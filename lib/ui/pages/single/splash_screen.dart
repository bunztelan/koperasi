import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:k2ms_v2/blocs/sign_in/sign_in_local.dart';
import 'package:k2ms_v2/config/color_config.dart';
import 'package:k2ms_v2/config/route/dashboard_location.dart';
import 'package:k2ms_v2/config/route/general_location.dart';
import 'package:k2ms_v2/config/route/dashboard_location.dart';

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
        Beamer.of(context).clearBeamStateHistory();
        Beamer.of(context).clearBeamLocationHistory();
        Beamer.of(context).beamTo(DashboardLocation());
      } else {
        Beamer.of(context).clearBeamStateHistory();
        Beamer.of(context).clearBeamLocationHistory();
        Beamer.of(context).beamTo(GeneralLocation());
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
        width: double.infinity,
        color: AppColor.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Koperasi',
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: AppColor.textPrimaryColor),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColor.textPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'By Koperasi Karyawan Mitra Sejahtera',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: AppColor.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
