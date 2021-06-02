import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:k2ms_v2/config/route/product_location.dart';

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
        buttonTitle1: "Selesai",
        buttonAction1: () {
          Beamer.of(context).clearBeamStateHistory();
          Beamer.of(context).clearBeamLocationHistory();
          Beamer.of(context).beamTo(ProductLocation());
        },
      ),
    );
    ;
  }
}
