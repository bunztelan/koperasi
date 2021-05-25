import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/pages/single/illustration_page.dart';

class ConfirmationMailPage extends StatelessWidget {
  ConfirmationMailPage({Key key}) : super(key: key);

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
        buttonTitle1: "Masuk",
        buttonAction1: () {
          Beamer.of(context).beamToNamed(RouteName.generalSignUpSuccess);
        },
      ),
    );
  }
}
