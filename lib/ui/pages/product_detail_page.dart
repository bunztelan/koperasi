part of 'pages.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  ProductDetailPage({this.productId});

  @override
  _ProductDetailPageState createState() {
    return _ProductDetailPageState();
  }
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  bool _onCart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        quantity = BlocProvider.of<OrderCubit>(context).setOrderQty(
            Beamer.of(context).currentBeamLocation.state.data['detailProduct']);
        _onCart = BlocProvider.of<OrderCubit>(context).searchOrderProduct(
                    Beamer.of(context)
                        .currentBeamLocation
                        .state
                        .data['detailProduct']
                        .id) ==
                -1
            ? false
            : true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColor.primaryColor,
          ),
          SafeArea(
            child: Container(
              color: Colors.white,
            ),
          ),
          SafeArea(
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/300"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListView(
            children: [
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Beamer.of(context).popRoute();
                    },
                    child: Container(
                      padding: EdgeInsets.all(3),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.black12,
                      ),
                      child: Image.asset("assets/arrow_back.png"),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 180),
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              (_onCart ? 230 : 200),
                          child: Text(
                            Beamer.of(context)
                                .currentBeamLocation
                                .state
                                .data['detailProduct']
                                .name,
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: '020202'.toColor(),
                                    ),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                //todo add alert when user want to reduce quantity to 0
                                setState(() {
                                  quantity = max(1, quantity - 1);
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(width: 1),
                                ),
                                child: Icon(
                                  CupertinoIcons.minus,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: Text(
                                "$quantity",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity = min(99, quantity + 1);
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(width: 1),
                                ),
                                child: Icon(
                                  CupertinoIcons.plus,
                                ),
                              ),
                            ),
                            !_onCart
                                ? Container()
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _onCart = false;
                                        quantity = 1;
                                      });
                                      CustomSnackbar.showSuccessSnackbar(
                                          context,
                                          'Produk dihapus dari keranjang.');
                                      BlocProvider.of<OrderCubit>(context)
                                          .removeItem(
                                        Beamer.of(context)
                                            .currentBeamLocation
                                            .state
                                            .data['detailProduct']
                                            .id,
                                      );
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      margin: EdgeInsets.only(left: 16),
                                      decoration: BoxDecoration(
                                        color: AppColor.roseColor,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: AppColor.roseColor,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.close_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      child: Text(
                        Beamer.of(context)
                            .currentBeamLocation
                            .state
                            .data['detailProduct']
                            .description,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 15,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: 26,
                  horizontal: 24,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Harga Total",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: AppColor.softGrayColor,
                              ),
                        ),
                        Text(
                          NumberFormat.currency(
                            symbol: "IDR ",
                            decimalDigits: 0,
                            locale: "id-ID",
                          ).format(
                            (Beamer.of(context)
                                    .currentBeamLocation
                                    .state
                                    .data['detailProduct']
                                    .price *
                                quantity),
                          ),
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<OrderCubit>(context).setOrder(
                          Beamer.of(context)
                              .currentBeamLocation
                              .state
                              .data['detailProduct'],
                          quantity,
                        );
                        Beamer.of(context).beamToNamed(
                          '/${RouteName.userDashboard}/${RouteName.userProductDetail}/${RouteName.userOrderCheckout}',
                        );
                      },
                      child: Text(
                        "Tambah",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.textPrimaryColor,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColor.primaryColor),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
