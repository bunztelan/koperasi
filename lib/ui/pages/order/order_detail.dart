import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:k2ms_v2/blocs/checkout/cubit/checkout_cubit.dart';
import 'package:k2ms_v2/blocs/order/cubit/order_cubit.dart';
import 'package:k2ms_v2/blocs/order_backend/cubit/order_backend_cubit.dart';
import 'package:k2ms_v2/blocs/token/cubit/token_cubit.dart';
import 'package:k2ms_v2/blocs/user/cubit/user_cubit.dart';
import 'package:k2ms_v2/models/order.dart';
import 'package:k2ms_v2/ui/widgets/custom_snackbar.dart';
import 'package:k2ms_v2/ui/widgets/loading_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../config/color_config.dart';
import '../../../config/route/route_name.dart';
import '../../widgets/custom_header.dart';

class OrderDetailPage extends StatefulWidget {
  OrderDetailPage({Key key}) : super(key: key);

  @override
  OrderDetailPageState createState() {
    return OrderDetailPageState();
  }
}

enum MethodStatus { DELIVERY, PICKUP }

class OrderDetailPageState extends State<OrderDetailPage> {
  @override
  void initState() {
    BlocProvider.of<OrderCubit>(context).getOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state is CheckkoutErrorState) {
            Navigator.pop(context);
            CustomSnackbar.showDangerSnackbar(
                context, 'Gagal melakukan pesanan, coba kembali.');
          } else if (state is CheckoutLoadedState) {
            Navigator.pop(context);
            Beamer.of(context).beamToNamed(
              '/${RouteName.userDashboard}/${RouteName.generalOrderSuccess}',
            );
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24),
          height: MediaQuery.of(context).size.height,
          color: AppColor.bodyColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(
                  title: 'Detail Order',
                  subTitle: 'Detail pesanan anda',
                  backFunction: () => Navigator.pop(context),
                  isBackIcon: false,
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
                      BlocBuilder<OrderBackendCubit, OrderBackendState>(
                        builder: (context, state) {
                          if (state is OrderBackendLoadedState) {
                            List<Order> orders = Beamer.of(context)
                                .currentBeamLocation
                                .state
                                .data['detailOrder']
                                .orders;
                            return Column(
                              children: orders.map(
                                (e) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: ItemCard(
                                      e.product.name,
                                      e.product.price.toString(),
                                      e.qty.toString(),
                                    ),
                                  );
                                },
                              ).toList(),
                            );
                          }
                          return Container();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Harga Total",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                            ),
                            Text(
                              NumberFormat.currency(
                                symbol: "IDR ",
                                decimalDigits: 0,
                                locale: "id-ID",
                              ).format(Beamer.of(context)
                                  .currentBeamLocation
                                  .state
                                  .data['detailOrder']
                                  .totalPrice),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
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
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Metode",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: AppColor.textPrimaryColor,
                            ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Metode Pengantaran ",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: AppColor.textHintColor,
                                    ),
                          ),
                          Text(
                            Beamer.of(context)
                                        .currentBeamLocation
                                        .state
                                        .data['detailOrder']
                                        .method ==
                                    'delivery'
                                ? 'Diantar'
                                : 'Ambil Sendiri',
                            textAlign: TextAlign.right,
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: AppColor.textPrimaryColor,
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Catatan ",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: AppColor.textHintColor,
                                    ),
                          ),
                          Text(
                            Beamer.of(context)
                                            .currentBeamLocation
                                            .state
                                            .data['detailOrder']
                                            .note ==
                                        null ||
                                    Beamer.of(context)
                                            .currentBeamLocation
                                            .state
                                            .data['detailOrder']
                                            .note
                                            .length ==
                                        0
                                ? '-'
                                : Beamer.of(context)
                                    .currentBeamLocation
                                    .state
                                    .data['detailOrder']
                                    .note,
                            textAlign: TextAlign.right,
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: AppColor.textPrimaryColor,
                                    ),
                          ),
                        ],
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
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: AppColor.textHintColor,
                                    ),
                          ),
                          Text(
                            context.read<UserCubit>().state.user.name,
                            textAlign: TextAlign.right,
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: AppColor.textHintColor,
                                    ),
                          ),
                          Text(
                            context.read<UserCubit>().state.user.phoneNumber,
                            textAlign: TextAlign.right,
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: AppColor.textHintColor,
                                    ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 160,
                            child: Text(
                              context.read<UserCubit>().state.user.address +
                                  context
                                      .read<UserCubit>()
                                      .state
                                      .user
                                      .addressDesc,
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: AppColor.textPrimaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "QR Code",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: AppColor.textPrimaryColor,
                              ),
                        ),
                      ),
                      SizedBox(height: 24),
                      QrImage(
                        data: "1234567890",
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36),
              ],
            ),
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
