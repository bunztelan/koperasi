import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/pages/pages.dart';

class DashboardLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          child: DashboardPage(),
          key: ValueKey(RouteName.userDashboard),
        ),
        if (state.uri.pathSegments.contains(RouteName.updateProfile))
          BeamPage(
            child: UpdateProfilePage(),
            key: ValueKey(RouteName.updateProfile),
          ),
        if (state.uri.pathSegments.contains(RouteName.updateAddress))
          BeamPage(
            child: UpdateAddressPage(),
            key: ValueKey(RouteName.updateAddress),
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
        '/${RouteName.userDashboard}/${RouteName.updateProfile}',
        '/${RouteName.userDashboard}/${RouteName.updateAddress}',
        '/${RouteName.userDashboard}/:productId',
      ];
}
