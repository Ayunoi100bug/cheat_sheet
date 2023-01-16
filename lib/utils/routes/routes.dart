import 'package:auto_route/annotations.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:cheat_sheet/view/create_sheet_screen/create_sheet_screen.dart';
import 'package:cheat_sheet/view/home_screen/detail_sheet.dart';
import 'package:cheat_sheet/view/home_screen/read_sheet.dart';
import 'package:cheat_sheet/view/home_screen/review_sheet.dart';
import 'package:cheat_sheet/view/login.dart';
import 'package:cheat_sheet/view/main_screen.dart';
import 'package:cheat_sheet/view/home_screen/home_screen.dart';
import 'package:cheat_sheet/view/activity_screen/activity_screen.dart';
import 'package:cheat_sheet/view/profile_screen/profile_screen.dart';
import 'package:cheat_sheet/view/register.dart';
import 'package:cheat_sheet/view/sheet_list_screen/sheet_list_screen.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute(
    path: '/',
    page: MainScreen,
    children: [
      AutoRoute(
          path: 'home',
          name: 'HomeRoute',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: HomeScreen),
            AutoRoute(
              path: 'detail_sheet',
              name: 'DetailSheetRoute',
              page: EmptyRouterPage,
              children: [
                AutoRoute(path: '', page: DetailSheet),
                AutoRoute(
                  path: 'read_sheet',
                  name: 'ReadSheetRoute',
                  page: ReadSheet,
                ),
                AutoRoute(
                  path: 'review_sheet',
                  name: 'ReviewSheetRoute',
                  page: ReviewSheet,
                ),
              ],
            ),
          ]),
      AutoRoute(
          path: 'activity',
          name: 'ActivityRoute',
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
  ),
  AutoRoute(
    path: '/register',
    name: 'RegisterRoute',
    page: RegisterScreen,
  ),
])
class $AppRouter {}
