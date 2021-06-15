import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k2ms_v2/blocs/category/category_repository_imp.dart';
import 'package:k2ms_v2/blocs/category/cubit/category_cubit.dart';
import 'package:k2ms_v2/blocs/checkout/checkout_repository_imp.dart';
import 'package:k2ms_v2/blocs/checkout/cubit/checkout_cubit.dart';
import 'package:k2ms_v2/blocs/order/cubit/order_cubit.dart';
import 'package:k2ms_v2/blocs/order_backend/cubit/order_backend_cubit.dart';
import 'package:k2ms_v2/blocs/order_backend/order_backend_repository_imp.dart';
import 'package:k2ms_v2/blocs/product/cubit/product_cubit.dart';
import 'package:k2ms_v2/blocs/product/product_repository_imp.dart';
import 'package:k2ms_v2/blocs/user/cubit/user_cubit.dart';
import 'package:k2ms_v2/config/route/dashboard_location.dart';
import 'package:k2ms_v2/config/route/general_location.dart';
import 'package:k2ms_v2/config/route/order_location.dart';
import 'package:k2ms_v2/config/route/splash_location.dart';

import 'blocs/token/cubit/token_cubit.dart';
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
