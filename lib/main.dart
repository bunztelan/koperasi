import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:k2ms_v2/ui/pages/pages.dart';
import 'package:k2ms_v2/ui/pages/single/confirmation_mail_page.dart';
import 'package:k2ms_v2/ui/pages/single/order_made_page.dart';
import 'package:k2ms_v2/ui/pages/single/signup_complete_page.dart';

import 'config/route/route_name.dart';
import 'config/theme_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _routerDelegate = BeamerRouterDelegate(
    locationBuilder: SimpleLocationBuilder(
      routes: {
        '/': (context) => SignInPage(),
        RouteName.authSignIn: (context) => SignInPage(),
        RouteName.authSignUp: (context) => SignUpPage(),
        RouteName.userManageAddress: (context) => AddAddressPage(),
        RouteName.generalConfirmationMail: (context) => ConfirmationMailPage(),
        RouteName.generalSignUpSuccess: (context) => SignUpCompletePage(),
        RouteName.generalOrderSuccess: (context) => OrderMadePage(),
        RouteName.userDashboard: (context) => DashboardPage(),
        RouteName.userProductDetail: (context) => ProductDetailPage(),
        RouteName.userOrderCheckout: (context) => CheckoutPage(),
      },
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: defaultStyleConfig,
      routeInformationParser: BeamerRouteInformationParser(),
      routerDelegate: _routerDelegate,
    );
  }
}
