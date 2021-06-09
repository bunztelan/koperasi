import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/pages/pages.dart';
import 'package:k2ms_v2/ui/pages/single/order_made_page.dart';

import '../../ui/pages/order/checkout_page.dart';

class OrderLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          child: CheckoutPage(),
          key: ValueKey(RouteName.userOrderCheckout),
        ),
        if (state.uri.pathSegments.contains(RouteName.generalOrderSuccess))
          BeamPage(
            child: OrderMadePage(),
            key: ValueKey(RouteName.generalOrderSuccess),
          ),
        if (state.pathParameters.containsKey('productId'))
          BeamPage(
            key: ValueKey('product-${state.pathParameters['productId']}'),
            child: ProductDetailPage(
              productId: state.pathParameters['bookId'],
            ),
          ),
      ];

  @override
  // TODO: implement pathBlueprints
  List<String> get pathBlueprints => [
        '/${RouteName.userOrderCheckout}',
        '/${RouteName.userOrderCheckout}/${RouteName.generalOrderSuccess}',
        '/${RouteName.userOrderCheckout}/:productId'
      ];
}
