import 'package:flutter/material.dart';
import 'package:k2ms_v2/config/color_config.dart';

class LoadingDialog {
  static showLoadingDialog(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Container(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.all(12),
          width: 190,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                backgroundColor: AppColor.primaryColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColor.primaryLighterColor,
                ),
              ),
              SizedBox(height: 24),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
