import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:k2ms_v2/blocs/order/cubit/order_cubit.dart';
import 'package:k2ms_v2/blocs/order_backend/cubit/order_backend_cubit.dart';
import 'package:k2ms_v2/blocs/token/cubit/token_cubit.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/models/order.dart';
import 'package:k2ms_v2/models/ordered_item.dart';
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
    BlocProvider.of<OrderCubit>(context).getOrder();
    super.initState();
  }

  // Set tab content
  Widget setTabContent() {
    BlocProvider.of<OrderBackendCubit>(context)
        .getOrderBackend(context.read<TokenCubit>().state.token, 'ALL');

    switch (selectedIndex) {
      case 0:
        return CartTab();
      case 1:
        return ProccessTab();
      case 2:
        return CompletedTab();
      default:
        return Container();
    }
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
                      titles: ["Keranjang", "Dalam Proses", "Selesai"],
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
                      '$totalItem item  ⋅  ${NumberFormat.currency(
                        symbol: "IDR ",
                        decimalDigits: 0,
                        locale: "id-ID",
                      ).format(int.parse(price))}',
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

/// Item Card
class ItemCard extends StatelessWidget {
  final String title;
  final String price;

  ItemCard(this.title, this.price);

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
              )
            ],
          )
        ],
      ),
    );
  }
}

/// Cart Tab
class CartTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoadedState) {
          List<Order> orders = state.orders;
          if (orders.length < 1 || orders == null) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: 98,
                top: 74,
              ),
              child: Text(
                'Keranjang anda masih kosong.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: AppColor.black30),
              ),
            );
          }

          return Column(
            children: [
              Column(
                children: orders.map(
                  (e) {
                    return GestureDetector(
                      onTap: () {
                        Beamer.of(context).beamToNamed(
                          '/${RouteName.userDashboard}/:${e.product.id.toString()}',
                          data: {
                            'detailProduct': e.product,
                          },
                        );
                      },
                      child: ItemCard(
                        e.product.name,
                        e.product.price.toString(),
                      ),
                    );
                  },
                ).toList(),
              ),
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: TextButton(
                  onPressed: () {
                    Beamer.of(context).beamToNamed(
                      '/${RouteName.userDashboard}/${RouteName.userProductDetail}/${RouteName.userOrderCheckout}',
                    );
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
              SizedBox(height: 24),
            ],
          );
        }
        return Container();
      },
    );
  }
}

/// Proccess Tab
class ProccessTab extends StatelessWidget {
  String _countItem(List<Order> orders) {
    int total = 0;

    for (int i = 0; i < orders.length; i++) {
      total += orders[i].qty;
    }

    return total.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBackendCubit, OrderBackendState>(
      builder: (context, state) {
        if (state is OrderBackendLoadedState) {
          List<OrderedItem> proccessList = state.orders;

          proccessList.removeWhere((e) =>
              e.status == 'COMPLETED' ||
              e.status == 'CANCELLED' ||
              e.status == 'REJECTED');

          if (proccessList.length < 1 || proccessList == null) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: 98,
                top: 74,
              ),
              child: Text(
                'Anda tidak memiliki pesanan.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: AppColor.black30),
              ),
            );
          }

          return Column(
              children: proccessList.map(
            (e) {
              var index = state.orders.indexOf(e);

              return GestureDetector(
                onTap: () {
                  Beamer.of(context).beamToNamed(
                      '/${RouteName.userDashboard}/${RouteName.userOrderDetail}',
                      data: {'detailOrder': e});
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: index == (state.orders.length - 1) ? 50 : 0),
                  child: SufixItemCard(
                    title: 'ORDER ${e.id.toString()}',
                    price: e.totalPrice.toString(),
                    totalItem: _countItem(e.orders),
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
  String _countItem(List<Order> orders) {
    int total = 0;

    for (int i = 0; i < orders.length; i++) {
      total += orders[i].qty;
    }

    return total.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBackendCubit, OrderBackendState>(
      builder: (context, state) {
        if (state is OrderBackendLoadedState) {
          List<OrderedItem> proccessList = state.orders;

          proccessList.removeWhere((e) =>
              e.status != 'COMPLETED' ||
              e.status != 'CANCELLED' ||
              e.status != 'REJECTED');

          if (proccessList.length < 1 || proccessList == null) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: 98,
                top: 74,
              ),
              child: Text(
                'Histori anda masih kosong.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: AppColor.black30),
              ),
            );
          }

          return Column(
              children: proccessList.map(
            (e) {
              var index = state.orders.indexOf(e);

              return GestureDetector(
                onTap: () {
                  Beamer.of(context).beamToNamed(
                      '/${RouteName.userDashboard}/${RouteName.userOrderDetail}',
                      data: {'detailOrder': e});
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: index == (state.orders.length - 1) ? 50 : 0),
                  child: SufixItemCard(
                    title: 'ORDER ${e.id.toString()}',
                    price: e.totalPrice.toString(),
                    totalItem: _countItem(e.orders),
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
