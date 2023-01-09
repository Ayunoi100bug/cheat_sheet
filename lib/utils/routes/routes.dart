import 'package:cheat_sheet/utils/routes/routes_name.dart';
import 'package:cheat_sheet/view/createSheet_screen.dart';
import 'package:cheat_sheet/view/home/main_screen.dart';
import 'package:cheat_sheet/view/home_screen.dart';
import 'package:cheat_sheet/view/activity_screen.dart';
import 'package:cheat_sheet/view/profile_screen.dart';
import 'package:cheat_sheet/view/settingNotification_screen.dart';
import 'package:cheat_sheet/view/sheetList_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final argume = settings.arguments;

    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RoutesName.activity:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ActivityScreen());

      case RoutesName.createSheet:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CreateSheetScreen());

      case RoutesName.sheetList:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SheetListScreen());

      case RoutesName.profile:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProfileScreen());

      case RoutesName.main:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MainScreen());

      case RoutesName.settingNotification:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                const SettingNotificationScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
