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
      case routesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case routesName.activity:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ActivityScreen());

      case routesName.createSheet:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CreateSheetScreen());

      case routesName.sheetList:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SheetListScreen());

      case routesName.profile:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProfileScreen());

      case routesName.main:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MainScreen());

      case routesName.settingNotification:
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
