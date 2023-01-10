import 'package:auto_route/annotations.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:cheat_sheet/utils/routes/routes_name.dart';
import 'package:cheat_sheet/view/create_sheet_screen.dart';
import 'package:cheat_sheet/view/main_screen.dart';
import 'package:cheat_sheet/view/home_screen.dart';
import 'package:cheat_sheet/view/activity_screen.dart';
import 'package:cheat_sheet/view/profile_screen.dart';
import 'package:cheat_sheet/view/settingNotification_screen.dart';
import 'package:cheat_sheet/view/sheet_list_screen.dart';
import 'package:flutter/material.dart';

// class Routes {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     final argume = settings.arguments;

//     switch (settings.name) {
//       case RoutesName.home:
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const HomeScreen());

//       case RoutesName.activity:
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const ActivityScreen());

//       case RoutesName.createSheet:
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const CreateSheetScreen());

//       case RoutesName.sheetList:
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const SheetListScreen());

//       case RoutesName.profile:
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const ProfileScreen());

//       case RoutesName.main:
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const MainScreen());

//       case RoutesName.settingNotification:
//         return MaterialPageRoute(
//             builder: (BuildContext context) =>
//                 const SettingNotificationScreen());

//       default:
//         return MaterialPageRoute(builder: (_) {
//           return const Scaffold(
//             body: Center(
//               child: Text('No route defined'),
//             ),
//           );
//         });
//     }
//   }
// }

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute(
    path: '/',
    page: MainScreen,
    children: [
      AutoRoute(
          path: 'home',
          name: 'HomeScreenRoute',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: HomeScreen),
          ]),
      AutoRoute(
          path: 'activity',
          name: 'ActivityScreenRoute',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: ActivityScreen),
          ]),
      AutoRoute(
          path: 'create_sheet',
          name: 'CreateSheetRoute',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: CreateSheetScreen),
          ]),
      AutoRoute(
          path: 'sheet_list',
          name: 'SheetListRoute',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: SheetListScreen),
          ]),
      AutoRoute(
          path: 'profile',
          name: 'ProfileRoute',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: ProfileScreen),
          ]),
    ],
  ),
])
class $AppRouter {}
