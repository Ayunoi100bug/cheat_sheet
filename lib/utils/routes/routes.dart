import 'package:auto_route/annotations.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:cheat_sheet/view/create_sheet_screen.dart';
import 'package:cheat_sheet/view/login.dart';
import 'package:cheat_sheet/view/main_screen.dart';
import 'package:cheat_sheet/view/home_screen.dart';
import 'package:cheat_sheet/view/activity_screen.dart';
import 'package:cheat_sheet/view/profile_screen.dart';
import 'package:cheat_sheet/view/sheet_list_screen.dart';

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
  AutoRoute(
    path: '/login',
    name: 'LoginRoute',
    page: LoginScreen,
  )
])
class $AppRouter {}
