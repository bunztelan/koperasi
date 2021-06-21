import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/banner/banner_repository_imp.dart';
import 'blocs/banner/cubit/banner_cubit.dart';
import 'blocs/category/category_repository_imp.dart';
import 'blocs/category/cubit/category_cubit.dart';
import 'blocs/checkout/checkout_repository_imp.dart';
import 'blocs/checkout/cubit/checkout_cubit.dart';
import 'blocs/order/cubit/order_cubit.dart';
import 'blocs/order_backend/cubit/order_backend_cubit.dart';
import 'blocs/order_backend/order_backend_repository_imp.dart';
import 'blocs/product/cubit/product_cubit.dart';
import 'blocs/product/product_repository_imp.dart';
import 'blocs/token/cubit/token_cubit.dart';
import 'blocs/update_address/cubit/update_address_cubit.dart';
import 'blocs/update_address/update_address_repository_imp.dart';
import 'blocs/update_profile/cubit/update_profile_cubit.dart';
import 'blocs/update_profile/update_profile_repository_imp.dart';
import 'blocs/upload_photo/cubit/upload_photo_cubit.dart';
import 'blocs/upload_photo/upload_photo_repository_imp.dart';
import 'blocs/user/cubit/user_cubit.dart';
import 'config/route/dashboard_location.dart';
import 'config/route/general_location.dart';
import 'config/route/order_location.dart';
import 'config/route/splash_location.dart';
import 'config/theme_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        SplashlLocation(),
        GeneralLocation(),
        DashboardLocation(),
        OrderLocation(),
      ],
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BeamerProvider(
      routerDelegate: _routerDelegate,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>(create: (context) => UserCubit()),
          BlocProvider<TokenCubit>(create: (context) => TokenCubit()),
          BlocProvider<CategoryCubit>(
              create: (context) => CategoryCubit(CategoryRepositoryImp())),
          BlocProvider<ProductCubit>(
              create: (context) => ProductCubit(ProductRepositoryImp())),
          BlocProvider<OrderCubit>(create: (context) => OrderCubit()),
          BlocProvider<OrderBackendCubit>(
              create: (context) =>
                  OrderBackendCubit(OrderBackendRepositoryImp())),
          BlocProvider<CheckoutCubit>(
              create: (context) => CheckoutCubit(CheckoutRepositoryImp())),
          BlocProvider<UpdateProfileCubit>(
              create: (context) =>
                  UpdateProfileCubit(UpdateProfileRepositoryImp())),
          BlocProvider<UpdateAddressCubit>(
              create: (context) =>
                  UpdateAddressCubit(UpdateAddressRepositoryImp())),
          BlocProvider<UploadPhotoCubit>(
              create: (context) =>
                  UploadPhotoCubit(UploadPhotoRepositoryImp())),
          BlocProvider<BannerCubit>(
              create: (context) => BannerCubit(BannerRepositoryImp())),
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: defaultStyleConfig,
          routeInformationParser: BeamerParser(),
          routerDelegate: _routerDelegate,
        ),
      ),
    );
  }
}

class ProfileUpdateCubit {}
