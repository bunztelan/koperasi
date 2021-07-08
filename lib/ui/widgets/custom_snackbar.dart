import 'package:flutter/cupertino.dart';
import '../../config/color_config.dart';
import 'top_snackbar.dart';

class CustomSnackbar {
  static Future<void> showDangerSnackbar(
      BuildContext context, String message) async {
    TopSnackBar(
      message: message,
      backgroundColor: AppColor.textDangerColor,
      duration: Duration(
        seconds: 3,
      ),
    ).show(context);
  }

  static Future<void> showSuccessSnackbar(
      BuildContext context, String message) async {
    TopSnackBar(
      message: message,
      backgroundColor: AppColor.green,
      duration: Duration(
        seconds: 3,
      ),
    ).show(context);
  }

  static Future<void> showInfoSnackbar(
      BuildContext context, String message) async {
    TopSnackBar(
      message: message,
      backgroundColor: AppColor.textPrimaryColor,
      duration: Duration(
        seconds: 3,
      ),
    ).show(context);
  }
}
