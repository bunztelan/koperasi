part of 'pages.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int selectedIndex;

  @override
  void initState() {
    selectedIndex = 0;

    if (context.read<CategoryCubit>().state.categories != null &&
        context.read<CategoryCubit>().state.categories.length > 0) {
      context.read<ProductCubit>().getProduct(
            context.read<TokenCubit>().state.token,
            context.read<CategoryCubit>().state.categories[0].id.toString(),
          );
    }

    super.initState();
  }

  /// Set profile home name
  String _setProfileHomeName(String name) {
    if (name.trim().length > 8) {
      return name.trim().substring(0, 8) + '...';
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          Container(
            height: 130,
            width: double.infinity,
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.symmetric(vertical: 26, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/k2ms_logo.png'),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Koperasi Karyawan",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          "Mitra Sejahtera",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                BlocBuilder<UserCubit, UserState>(
                  bloc: BlocProvider.of<UserCubit>(context),
                  builder: (context, state) {
                    if (state is UserLoadingState) {
                      return ShimmerProfile();
                    } else if (state is UserLoadedState) {
                      return Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: context
                                                .read<UserCubit>()
                                                .state
                                                .user
                                                .avatar ==
                                            null ||
                                        context
                                                .read<UserCubit>()
                                                .state
                                                .user
                                                .avatar ==
                                            'null'
                                    ? AssetImage(
                                        'assets/default_avatar.png',
                                      )
                                    : NetworkImage(
                                        context
                                            .read<UserCubit>()
                                            .state
                                            .user
                                            .avatar,
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            context.read<UserCubit>().state.user == null
                                ? ''
                                : _setProfileHomeName(
                                    context.read<UserCubit>().state.user.name),
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
                      );
                    }

                    return Text('Load...');
                  },
                )
              ],
            ),
          ),
          BlocBuilder<BannerCubit, BannerState>(
            builder: (context, state) {
              if (state is BannerLoadingState) {
                return ShimmerBanner();
              } else if (state is BannerLoadedState) {
                return CarouselSlider(
                  options: CarouselOptions(height: 200.0),
                  items: state.banners.map((e) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            if (e.bannerLink == null ||
                                e.bannerLink.trim() == '') {
                              CustomSnackbar.showInfoSnackbar(context,
                                  'Banner tidak memiliki link saat ini.');
                            } else {
                              Beamer.of(context).beamToNamed(
                                  '/${RouteName.userDashboard}/${RouteName.userWebView}/${e.id}',
                                  data: {'title': e.name, 'url': e.bannerLink});
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 160,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: AppColor.softGrayColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: e.image != null && e.image != ''
                                          ? NetworkImage(e.image)
                                          : AssetImage(
                                              'assets/banner.jpg',
                                            ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  padding: EdgeInsets.all(8),
                                  child: Text(e.name),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              }
              return Container();
            },
          ),
          SizedBox(height: 24),
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoadedState) {
                      return CustomTabbar(
                        spaceEvenly: false,
                        titles: state.categories.map((e) => e.name).toList(),
                        selectedIndex: selectedIndex,
                        onTap: (index) async {
                          await BlocProvider.of<ProductCubit>(context)
                              .getProduct(
                            context.read<TokenCubit>().state.token,
                            state.categories[index].id.toString(),
                          );

                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(height: 16),
                BlocListener<CategoryCubit, CategoryState>(
                  listener: (context, state) {
                    if (state is CategoryLoadedState) {
                      if (state.categories.length > 0) {
                        {
                          BlocProvider.of<ProductCubit>(context).getProduct(
                              context.read<TokenCubit>().state.token,
                              state.categories[0].id.toString());
                        }
                      }
                    }
                  },
                  child: BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoadingState ||
                          state is ProductInitialState) {
                        return ShimmerItemList();
                      } else if (state is ProductLoadedState) {
                        if (state.products.length < 1 ||
                            state.products == null) {
                          return Center(
                            child: Container(
                              width: 250,
                              height:
                                  MediaQuery.of(context).size.height * 0.4 - 70,
                              child: Center(
                                child: Text(
                                    'Tidak ada produk untuk kategori ini sementara.',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(color: AppColor.black30)),
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: state.products.map(
                            (e) {
                              var index = state.products.indexOf(e);

                              return GestureDetector(
                                onTap: () {
                                  Beamer.of(context).beamToNamed(
                                    '/${RouteName.userDashboard}/:${state.products[index].id.toString()}',
                                    data: {
                                      'detailProduct': e,
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: index == state.products.length - 1
                                          ? 50
                                          : 0),
                                  child: ItemCard(
                                    e.name,
                                    e.price.toString(),
                                    image:
                                        e.images != null && e.images.length > 0
                                            ? e.images[0]
                                            : '',
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
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
  final String image;

  ItemCard(this.title, this.price, {this.image = ''});

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
              image == ''
                  ? SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/groceries.jpg'),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(image),
                        ),
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
