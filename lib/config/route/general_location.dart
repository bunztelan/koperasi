import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/pages/auth/send_email_confirm_password.dart';
import 'package:k2ms_v2/ui/pages/pages.dart';
import 'package:k2ms_v2/ui/pages/single/confirmation_mail_page.dart';

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
          ),
        if (state.uri.pathSegments.contains(RouteName.userManageAddress))
          BeamPage(
            child: AddAddressPage(),
            key: ValueKey(RouteName.userManageAddress),
          ),
        if (state.uri.pathSegments.contains(RouteName.authSECPassword))
          BeamPage(
            child: SECPasswordPage(),
            key: ValueKey(RouteName.authSECPassword),
          ),
        if (state.pathParameters.containsKey('status'))
          BeamPage(
            child: ConfirmationMailPage(
              status: state.pathParameters['status'],
            ),
            key: ValueKey(
                '${RouteName.generalConfirmationMail}-${state.pathParameters['status']}'),
          ),
      ];

  @override
  List<String> get pathBlueprints => [
        '/${RouteName.authSignUp}',
        '/${RouteName.authSignUp}/${RouteName.userManageAddress}',
        '/${RouteName.authSignUp}/${RouteName.userManageAddress}',
        '/${RouteName.authSignUp}/${RouteName.userManageAddress}/${RouteName.generalConfirmationMail}/:status',
        '/${RouteName.authSECPassword}',
        '/${RouteName.authSECPassword}/${RouteName.generalConfirmationMail}/:status',
      ];
}
