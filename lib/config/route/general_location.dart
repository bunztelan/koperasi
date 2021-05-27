import 'package:beamer/beamer.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/pages/pages.dart';
import 'package:k2ms_v2/ui/pages/single/splash_screen.dart';

class GeneralLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          child: SplashScreen(),
          key: ValueKey(RouteName.generalSplash),
        ),
        if (state.uri.pathSegments.contains(RouteName.authSignIn))
          BeamPage(
            child: SignInPage(),
            key: ValueKey(RouteName.authSignIn),
          ),
        if (state.uri.pathSegments.contains(RouteName.authSignUp))
          BeamPage(
            child: SignUpPage(),
            key: ValueKey(RouteName.authSignUp),
          ),
        if (state.uri.pathSegments.contains(RouteName.userManageAddress))
          BeamPage(
            child: AddAddressPage(),
            key: ValueKey(RouteName.userManageAddress),
          ),
      ];

  @override
  List<String> get pathBlueprints => [
        '/${RouteName.authSignIn}/${RouteName.authSignUp}',
        '/${RouteName.authSignIn}/${RouteName.authSignUp}/${RouteName.userManageAddress}',
      ];
}
