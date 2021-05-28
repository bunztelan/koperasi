import 'package:beamer/beamer.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/pages/pages.dart';

class GeneralLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          child: SignInPage(),
          key: ValueKey(RouteName.authSignIn),
        ),
        if (state.uri.pathSegments.contains(RouteName.authSignUp))
          BeamPage(
            child: SignUpPage(),
            key: ValueKey(RouteName.authSignUp),
            popToNamed: '/',
          ),
        if (state.uri.pathSegments.contains(RouteName.userManageAddress))
          BeamPage(
            child: AddAddressPage(),
            key: ValueKey(RouteName.userManageAddress),
          ),
      ];

  @override
  List<String> get pathBlueprints => [
        '/${RouteName.authSignUp}',
        '/${RouteName.authSignUp}/${RouteName.userManageAddress}',
      ];
}
