import 'package:flutter/material.dart';

import 'illustration_page.dart';

class OrderMadePage extends StatelessWidget {
  OrderMadePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 26,
        horizontal: 24,
      ),
      child: IllustrationPage(
        title: "Pesanan Diterima",
        subtitle:
        "Pesanan anda telah diterima, kami akan mempersiapkan pesanan anda",
        height: 290,
        width: 200,
        picturepath: "assets/order_made.png",
        buttonTitle1: "Lihat Pesanan",
        buttonAction1: () {},
      ),
    );;
  }
}
