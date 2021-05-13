import 'package:flutter/material.dart';
import 'package:k2ms_v2/ui/pages/single/confirmation_mail_page.dart';
import 'package:k2ms_v2/ui/pages/pages.dart';
import 'package:k2ms_v2/ui/pages/single/empty_order_page.dart';
import 'package:k2ms_v2/ui/pages/single/order_made_page.dart';
import 'package:k2ms_v2/ui/pages/single/signup_complete_page.dart';

import 'config/theme_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultStyleConfig,
      home:DashboardPage(),
    );
  }
}