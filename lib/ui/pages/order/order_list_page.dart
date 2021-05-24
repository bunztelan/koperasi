import 'package:flutter/material.dart';
import 'package:k2ms_v2/ui/widgets/widgets.dart';

import '../../../config/color_config.dart';
import '../../widgets/custom_header.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  int selectedIndex = 0;

  // Set tab content
  Widget setTabContent() {
    if (selectedIndex == 0) {
      return ProccessTab();
    }

    return CompletedTab();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.bodyColor,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeader(
                title: 'Daftar Pesanan',
                subTitle: 'Pesanan anda segera diantar',
              ),
              SizedBox(height: 24),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    CustomTabbar(
                      spaceEvenly: false,
                      titles: ["Proses", "Selesai"],
                      selectedIndex: selectedIndex,
                      onTap: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                    SizedBox(height: 24),
                    setTabContent(),
                  ],
                ),
              )
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
                      '$totalItem item  ⋅  IDR $price',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: AppColor.black30),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

/// Item Card with suffix
class SufixItemCard extends StatelessWidget {
  final String title;
  final String price;
  final String totalItem;
  final String date;
  final String status;

  SufixItemCard(
      {this.title, this.price, this.totalItem, this.date, this.status});

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
                      '$totalItem item  ⋅  IDR $price',
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    date,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: AppColor.black30,
                        ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    status,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: AppColor.textDangerColor,
                        ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

/// Proccess Tab
class ProccessTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemCard('Beras ABC', '75000', '3'),
        ItemCard('Minyak Goreng Bilomi', '23000', '4'),
        ItemCard('Minyak Goreng Uhuy Badai Bombai', '50000', '3'),
        ItemCard('Indomie Mie Instant', '1500', '1'),
      ],
    );
  }
}

/// Completed tab
class CompletedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SufixItemCard(
          title: 'Bluban cap sedap',
          price: '75000',
          totalItem: '5',
          date: 'Mei 2, 2021',
          status: 'cancelled',
        ),
      ],
    );
  }
}
