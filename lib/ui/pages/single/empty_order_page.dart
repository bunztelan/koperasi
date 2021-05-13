import 'package:flutter/material.dart';

import 'illustration_page.dart';

class EmptyOrderPage extends StatelessWidget {
  EmptyOrderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 26,
        horizontal: 24,
      ),
      child: IllustrationPage(
        title: "Tidak Ada Pesanan",
        subtitle:
        "Anda sepertinya belum pernah melakukan pemesanan",
        height: 290,
        width: 200,
        picturepath: "assets/empty_order.png",
        buttonTitle1: "Beranda",
        buttonAction1: () {},
      ),
    );
  }
}
