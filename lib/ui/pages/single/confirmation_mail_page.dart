import 'package:flutter/material.dart';
import 'package:k2ms_v2/ui/pages/single/illustration_page.dart';
import 'package:k2ms_v2/ui/widgets/custom_snackbar.dart';
import 'package:open_mail_app/open_mail_app.dart';

class ConfirmationMailPage extends StatelessWidget {
  ConfirmationMailPage({Key key}) : super(key: key);

  Future<void> _openMain(BuildContext context) async {
    var result = await OpenMailApp.openMailApp();

    if (!result.didOpen && !result.canOpen) {
      CustomSnackbar.showDangerSnackbar(
          context, 'Aplikasi email tidak ditemukan, buka melalui browser');
    } else if (!result.didOpen && result.canOpen) {
      // For iOS
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 26,
        horizontal: 24,
      ),
      child: IllustrationPage(
        title: "Email Konfirmasi Dikirm",
        subtitle:
            "Konfirmasi akun anda dengan menekan link yang ada pada email yang telah kami kirim",
        picturepath: "assets/mail_sent.png",
        buttonTitle1: "Cek Email",
        buttonAction1: () => _openMain(context),
      ),
    );
  }
}
