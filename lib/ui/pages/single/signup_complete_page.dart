import 'package:flutter/material.dart';

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
        "Akun anda telah berhasil di konfirmasi. Sekarang anda dapat masuk kedalam aplikasi",
        height: 290,
        width: 200,
        picturepath: "assets/signup_success.png",
        buttonTitle1: "Beranda",
        buttonAction1: () {},
      ),
    );
  }
}
