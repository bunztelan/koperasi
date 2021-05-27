import 'package:beamer/beamer.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/pages/pages.dart';

class DashboardLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          child: DashboardPage(),
          key: ValueKey(
            RouteName.userDashboard,
          ),
        )
      ];

  @override
  List<String> get pathBlueprints => ['/${RouteName.userDashboard}'];
}
