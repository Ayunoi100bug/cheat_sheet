// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:auto_route/empty_router_widgets.dart' as _i3;
import 'package:flutter/material.dart' as _i11;

import '../../view/activity_screen/activity_screen.dart' as _i6;
import '../../view/create_sheet_screen/create_sheet_screen.dart' as _i7;
import '../../view/home_screen/detail_sheet.dart' as _i5;
import '../../view/home_screen/home_screen.dart' as _i4;
import '../../view/login.dart' as _i2;
import '../../view/main_screen.dart' as _i1;
import '../../view/profile_screen/profile_screen.dart' as _i9;
import '../../view/sheet_list_screen/sheet_list_screen.dart' as _i8;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MainScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.EmptyRouterPage(),
      );
    },
    ActivityRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.EmptyRouterPage(),
      );
    },
    CreateSheetRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.EmptyRouterPage(),
      );
    },
    SheetListRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.EmptyRouterPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.EmptyRouterPage(),
      );
    },
    HomeScreen.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.HomeScreen(),
      );
    },
    DetailSheetRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.DetailSheet(),
      );
    },
    ActivityScreen.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.ActivityScreen(),
      );
    },
    CreateSheetScreen.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.CreateSheetScreen(),
      );
    },
    SheetListScreen.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.SheetListScreen(),
      );
    },
    ProfileScreen.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.ProfileScreen(),
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          MainScreen.name,
          path: '/',
          children: [
            _i10.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainScreen.name,
              children: [
                _i10.RouteConfig(
                  HomeScreen.name,
                  path: '',
                  parent: HomeRoute.name,
                ),
                _i10.RouteConfig(
                  DetailSheetRoute.name,
                  path: 'detail_sheet',
                  parent: HomeRoute.name,
                ),
              ],
            ),
            _i10.RouteConfig(
              ActivityRoute.name,
              path: 'activity',
              parent: MainScreen.name,
              children: [
                _i10.RouteConfig(
                  ActivityScreen.name,
                  path: '',
                  parent: ActivityRoute.name,
                )
              ],
            ),
            _i10.RouteConfig(
              CreateSheetRoute.name,
              path: 'create_sheet',
              parent: MainScreen.name,
              children: [
                _i10.RouteConfig(
                  CreateSheetScreen.name,
                  path: '',
                  parent: CreateSheetRoute.name,
                )
              ],
            ),
            _i10.RouteConfig(
              SheetListRoute.name,
              path: 'sheet_list',
              parent: MainScreen.name,
              children: [
                _i10.RouteConfig(
                  SheetListScreen.name,
                  path: '',
                  parent: SheetListRoute.name,
                )
              ],
            ),
            _i10.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: MainScreen.name,
              children: [
                _i10.RouteConfig(
                  ProfileScreen.name,
                  path: '',
                  parent: ProfileRoute.name,
                )
              ],
            ),
          ],
        ),
        _i10.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreen extends _i10.PageRouteInfo<void> {
  const MainScreen({List<_i10.PageRouteInfo>? children})
      : super(
          MainScreen.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class ActivityRoute extends _i10.PageRouteInfo<void> {
  const ActivityRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ActivityRoute.name,
          path: 'activity',
          initialChildren: children,
        );

  static const String name = 'ActivityRoute';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class CreateSheetRoute extends _i10.PageRouteInfo<void> {
  const CreateSheetRoute({List<_i10.PageRouteInfo>? children})
      : super(
          CreateSheetRoute.name,
          path: 'create_sheet',
          initialChildren: children,
        );

  static const String name = 'CreateSheetRoute';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class SheetListRoute extends _i10.PageRouteInfo<void> {
  const SheetListRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SheetListRoute.name,
          path: 'sheet_list',
          initialChildren: children,
        );

  static const String name = 'SheetListRoute';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i4.HomeScreen]
class HomeScreen extends _i10.PageRouteInfo<void> {
  const HomeScreen()
      : super(
          HomeScreen.name,
          path: '',
        );

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i5.DetailSheet]
class DetailSheetRoute extends _i10.PageRouteInfo<void> {
  const DetailSheetRoute()
      : super(
          DetailSheetRoute.name,
          path: 'detail_sheet',
        );

  static const String name = 'DetailSheetRoute';
}

/// generated route for
/// [_i6.ActivityScreen]
class ActivityScreen extends _i10.PageRouteInfo<void> {
  const ActivityScreen()
      : super(
          ActivityScreen.name,
          path: '',
        );

  static const String name = 'ActivityScreen';
}

/// generated route for
/// [_i7.CreateSheetScreen]
class CreateSheetScreen extends _i10.PageRouteInfo<void> {
  const CreateSheetScreen()
      : super(
          CreateSheetScreen.name,
          path: '',
        );

  static const String name = 'CreateSheetScreen';
}

/// generated route for
/// [_i8.SheetListScreen]
class SheetListScreen extends _i10.PageRouteInfo<void> {
  const SheetListScreen()
      : super(
          SheetListScreen.name,
          path: '',
        );

  static const String name = 'SheetListScreen';
}

/// generated route for
/// [_i9.ProfileScreen]
class ProfileScreen extends _i10.PageRouteInfo<void> {
  const ProfileScreen()
      : super(
          ProfileScreen.name,
          path: '',
        );

  static const String name = 'ProfileScreen';
}
