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
  int _selectedSlider = 0; // Image slider index

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

  /// Set indicator for image slider
  Widget _setImageIdicator(int number) {
    List<Widget> dotList = [];

    for (int i = 0; i < number; i++) {
      dotList.add(
        Container(
          width: 15,
          height: 15,
          margin: EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: _selectedSlider == i
                ? AppColor.primaryColor
                : AppColor.softGrayColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: dotList.toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        width: double.infinity,
        height: 120,
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColor.primaryColor),
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
      body: Stack(
        children: [
          Container(
            color: AppColor.primaryColor,
            height: MediaQuery.of(context).size.height,
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  child: Stack(
                    children: [
                      Beamer.of(context)
                                      .currentBeamLocation
                                      .state
                                      .data['detailProduct']
                                      .images !=
                                  null &&
                              Beamer.of(context)
                                      .currentBeamLocation
                                      .state
                                      .data['detailProduct']
                                      .images
                                      .length >
                                  0
                          ? CarouselSlider(
                              options: CarouselOptions(
                                height: 300,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _selectedSlider = index;
                                  });
                                },
                              ),
                              items: Beamer.of(context)
                                  .currentBeamLocation
                                  .state
                                  .data['detailProduct']
                                  .images
                                  .map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration:
                                          BoxDecoration(color: Colors.amber),
                                      child: Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(i),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            )
                          : Container(
                              height: 300,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/groceries.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              Beamer.of(context).popRoute();
                            },
                            iconSize: 38,
                            icon: Icon(FeatherIcons.chevronLeft),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: _setImageIdicator(
                          Beamer.of(context)
                                          .currentBeamLocation
                                          .state
                                          .data['detailProduct']
                                          .images !=
                                      null &&
                                  Beamer.of(context)
                                          .currentBeamLocation
                                          .state
                                          .data['detailProduct']
                                          .images
                                          .length >
                                      0
                              ? Beamer.of(context)
                                  .currentBeamLocation
                                  .state
                                  .data['detailProduct']
                                  .images
                                  .length
                              : 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 26, horizontal: 24),
                    decoration: BoxDecoration(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 21,
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
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontSize: 15,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
