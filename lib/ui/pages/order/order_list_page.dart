import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:k2ms_v2/blocs/order_backend/cubit/order_backend_cubit.dart';
import 'package:k2ms_v2/blocs/token/cubit/token_cubit.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/widgets/widgets.dart';

import '../../../config/color_config.dart';
import '../../widgets/custom_header.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    BlocProvider.of<OrderBackendCubit>(context)
        .getOrderBackend(context.read<TokenCubit>().state.token, 'ALL');
    super.initState();
  }

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
                title: 'Pesanan',
                subTitle: 'Daftar pesanan anda',
                backButton: false,
              ),
              SizedBox(height: 24),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    CustomTabbar(
                      spaceEvenly: false,
                      titles: ["Dalam Proses", "Selesai"],
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

  String _setStatus(String status) {
    switch (status) {
      case 'CONFIRM':
        return 'Pesanan Dikonfirmasi';
      case 'PENDING':
        return 'Pending';
      case 'ON_DELIVERY':
        return 'Dikirim';
      case 'COMPLETED':
        return 'Diterima';
      case 'REJECTED':
        return 'Diterima';
      case 'CANCELLED':
        return 'Dibatalkan';
      default:
        return '';
    }
  }

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
                    _setStatus(status),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: AppColor.green,
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
    return BlocBuilder<OrderBackendCubit, OrderBackendState>(
      builder: (context, state) {
        if (state is OrderBackendLoadedState) {
          return Column(
              children: state.orders.map(
            (e) {
              var index = state.orders.indexOf(e);

              return GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: index == (state.orders.length - 1) ? 50 : 0),
                  child: SufixItemCard(
                    title: 'ORDER ${e.id.toString()}',
                    price: e.totalPrice.toString(),
                    totalItem: '5',
                    date: DateFormat("dd MMM, yyyy HH:mm")
                        .format(DateTime.parse(e.updatedAt)),
                    status: e.status,
                  ),
                ),
              );
            },
          ).toList());
        }
        return Container();
      },
    );
  }
}

/// Completed tab
class CompletedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: SufixItemCard(
            title: 'Bluban cap sedap',
            price: '75000',
            totalItem: '5',
            date: 'Mei 2, 2021',
            status: 'Dibatalkan',
          ),
        ),
      ],
    );
  }
}
