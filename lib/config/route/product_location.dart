import 'package:beamer/beamer.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/pages/pages.dart';

class ProductLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          child: DashboardPage(),
          key: ValueKey(RouteName.userDashboard),
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
  List<String> get pathBlueprints => [
        '/${RouteName.userDashboard}',
        '/${RouteName.userDashboard}/:productId',
      ];
}
