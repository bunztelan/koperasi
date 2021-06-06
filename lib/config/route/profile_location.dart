import 'package:beamer/beamer.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/pages/pages.dart';

class ProfileLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          child: UpdateProfilePage(),
          key: ValueKey(RouteName.updateProfile),
        )
      ];

  @override
  List<String> get pathBlueprints => [
        '/${RouteName.userDashboard}/${RouteName.updateProfile}',
      ];
}
