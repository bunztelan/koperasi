import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:k2ms_v2/config/route/general_location.dart';
import 'package:k2ms_v2/config/route/route_name.dart';

import 'illustration_page.dart';

class SignUpCompletePage extends StatelessWidget {
  SignUpCompletePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 26,
        horizontal: 24,
      ),
      child: IllustrationPage(
        title: "Pendaftaran Selesai",
        subtitle:
            "Akun anda berhasil di konfirmasi. Sekarang anda dapat masuk ke dalam aplikasi",
        height: 290,
        width: 200,
        picturepath: "assets/signup_success.png",
        buttonTitle1: "Masuk",
        buttonAction1: () {
          Beamer.of(context).beamStateHistory.clear();
          Beamer.of(context).beamLocationHistory.clear();
          Beamer.of(context).beamTo(GeneralLocation());
        },
      ),
    );
  }
}
