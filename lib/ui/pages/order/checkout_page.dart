import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../config/color_config.dart';
import '../../../config/route/route_name.dart';
import '../../widgets/custom_header.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({Key key}) : super(key: key);

  @override
  _CheckoutPageState createState() {
    return _CheckoutPageState();
  }
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 24),
        height: MediaQuery.of(context).size.height,
        color: AppColor.bodyColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeader(
                title: 'Pesanan Anda',
                subTitle: 'Periksa kembali pesanan anda',
                parentContext: context,
              ),
              SizedBox(height: 24),
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Daftar Pesanan",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: AppColor.textPrimaryColor,
                            ),
                      ),
                    ),
                    SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        Beamer.of(context).beamToNamed(
                            '/${RouteName.userOrderCheckout}/:productId');
                      },
                      child: ItemCard('Blue Band', '80000', '14'),
                    ),
                    ItemCard('Minyak Goreng Shaniul', '43000', '14'),
                    ItemCard('Mie Rebus Mi Sari', '23000', '14'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Harga Total",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                          ),
                          Text(
                            NumberFormat.currency(
                              symbol: "IDR ",
                              decimalDigits: 0,
                              locale: "id-ID",
                            ).format(50000),
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lokasi Pengantaran",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: AppColor.textPrimaryColor,
                          ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nama ",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: AppColor.textHintColor,
                              ),
                        ),
                        Text(
                          "Angga Rizky",
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: AppColor.textPrimaryColor,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "No Telp ",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: AppColor.textHintColor,
                              ),
                        ),
                        Text(
                          "08224556333",
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: AppColor.textPrimaryColor,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Alamat ",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: AppColor.textHintColor,
                              ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 160,
                          child: Text(
                            "Jalan joyo raharjo 281B, RT 04,RW 02, Kelurahan Merjosari, Kecamatan Lowokwaru, Kota Malang Kodepos:65144",
                            textAlign: TextAlign.right,
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: AppColor.textPrimaryColor,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 36),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Beamer.of(context).beamToNamed(
                        '/${RouteName.userOrderCheckout}/${RouteName.generalOrderSuccess}');
                  },
                  child: Text(
                    "Pesan Sekarang",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textPrimaryColor,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColor.primaryColor),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Item Card
class ItemCard extends StatelessWidget {
  final String title;
  final String price;
  final String totalItem;

  ItemCard(this.title, this.price, this.totalItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        bottom: 24,
        right: 24,
        left: 24,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColor.softGrayColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      NumberFormat.currency(
                        symbol: "IDR ",
                        decimalDigits: 0,
                        locale: "id-ID",
                      ).format(int.parse(price)),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: AppColor.black30),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5),
              Text(
                '$totalItem Item',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: AppColor.black30,
                    ),
              )
            ],
          )
        ],
      ),
    );
  }
}
