import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:k2ms_v2/blocs/checkout/cubit/checkout_cubit.dart';
import 'package:k2ms_v2/blocs/order/cubit/order_cubit.dart';
import 'package:k2ms_v2/blocs/token/cubit/token_cubit.dart';
import 'package:k2ms_v2/blocs/user/cubit/user_cubit.dart';
import 'package:k2ms_v2/models/order.dart';
import 'package:k2ms_v2/ui/widgets/custom_snackbar.dart';
import 'package:k2ms_v2/ui/widgets/loading_dialog.dart';

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

enum MethodStatus { DELIVERY, PICKUP }

class _CheckoutPageState extends State<CheckoutPage> {
  MethodStatus _method = MethodStatus.DELIVERY;
  TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<OrderCubit>(context).getOrder();
    super.initState();
  }

  int _countTotalPrice(List<Order> orders) {
    int total = 0;

    for (int i = 0; i < orders.length; i++) {
      total += (orders[i].product.price * orders[i].qty);
    }

    return total;
  }

  void _checkout() {
    LoadingDialog.showLoadingDialog(context, 'Memesan...');
    BlocProvider.of<CheckoutCubit>(context).checkout(
      authToken: context.read<TokenCubit>().state.token,
      method: _method == MethodStatus.DELIVERY ? 'delivery' : 'pickup',
      note: _noteController.text,
      orders: BlocProvider.of<OrderCubit>(context).orders,
    );
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

            // Remove cart when success checkout
            List<Order> emptyOrder = [];
            BlocProvider.of<OrderCubit>(context).initialData(emptyOrder);

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
                  title: 'Pesanan Anda',
                  subTitle: 'Periksa kembali pesanan anda',
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
                      BlocBuilder<OrderCubit, OrderState>(
                        builder: (context, state) {
                          if (state is OrderLoadedState) {
                            return Column(
                              children: state.orders
                                  .map(
                                    (e) => GestureDetector(
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
                                        e.qty.toString(),
                                      ),
                                    ),
                                  )
                                  .toList(),
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
                              ).format(_countTotalPrice(
                                  context.read<OrderCubit>().orders)),
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
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                            color: AppColor.black70,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                Radio<MethodStatus>(
                                  activeColor: AppColor.textPrimaryColor,
                                  value: MethodStatus.DELIVERY,
                                  groupValue: _method,
                                  onChanged: (MethodStatus value) {
                                    setState(() {
                                      _method = value;
                                    });
                                  },
                                ),
                                Text('Delivery'),
                              ],
                            ),
                            SizedBox(width: 24),
                            Row(
                              children: [
                                Radio<MethodStatus>(
                                  value: MethodStatus.PICKUP,
                                  activeColor: AppColor.textPrimaryColor,
                                  groupValue: _method,
                                  onChanged: (MethodStatus value) {
                                    setState(() {
                                      _method = value;
                                    });
                                  },
                                ),
                                Text('Pickup'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Text('*Hanya untuk metode delivery'),
                      SizedBox(height: 6),
                      TextFormField(
                        controller: _noteController,
                        maxLines: 5,
                        enabled:
                            _method == MethodStatus.DELIVERY ? true : false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColor.primaryColor,
                              width: 1,
                            ),
                          ),
                          hintStyle: GoogleFonts.poppins(
                            color: AppColor.softGrayColor,
                            fontSize: 14,
                          ),
                          hintText: "Catatan tambahan",
                        ),
                      )
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
                SizedBox(height: 36),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: _checkout,
                    child: Text(
                      "Pesan Sekarang",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textPrimaryColor,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColor.primaryColor),
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
