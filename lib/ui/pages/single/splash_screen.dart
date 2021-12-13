import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k2ms_v2/blocs/order/cubit/order_cubit.dart';
import 'package:k2ms_v2/blocs/sign_in/sign_in_local.dart';
import 'package:k2ms_v2/config/color_config.dart';
import 'package:k2ms_v2/config/route/dashboard_location.dart';
import 'package:k2ms_v2/config/route/general_location.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Navigate to to main screen
  Future _toMain() async {
    await Firebase.initializeApp();
    var getUserLocalData = await LocalData.getUserLocalData();
    var getCartLocalData = await LocalData.getCartLocalData();

    if (getCartLocalData != null && getCartLocalData.length > 0) {
      BlocProvider.of<OrderCubit>(context).initialData(getCartLocalData);
    }

    return Timer(Duration(seconds: 3), () async {
      if (getUserLocalData != null) {
        Beamer.of(context).beamTo(DashboardLocation());
        Beamer.of(context).clearBeamStateHistory();
        Beamer.of(context).clearBeamLocationHistory();
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
      bottomSheet: Container(
        width: double.infinity,
        height: 70,
        color: AppColor.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: AppColor.textPrimaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Version 1.0.0',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: AppColor.primaryColor),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: AppColor.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                'assets/k2ms_logo.png',
              ),
              height: 164,
            ),
          ],
        ),
      ),
    );
  }
}
