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
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:flutter/material.dart' as _i17;

import '../../view/activity_screen/activity_screen.dart' as _i11;
import '../../view/create_sheet_screen/create_detail_sheet.dart' as _i13;
import '../../view/create_sheet_screen/create_sheet_screen.dart' as _i12;
import '../../view/home_screen/ask_question.dart' as _i10;
import '../../view/home_screen/create_review.dart' as _i8;
import '../../view/home_screen/detail_sheet.dart' as _i6;
import '../../view/home_screen/home_screen.dart' as _i5;
import '../../view/home_screen/read_sheet.dart' as _i9;
import '../../view/home_screen/review_sheet.dart' as _i7;
import '../../view/login.dart' as _i2;
import '../../view/main_screen.dart' as _i1;
import '../../view/profile_screen/profile_screen.dart' as _i15;
import '../../view/register.dart' as _i3;
import '../../view/sheet_list_screen/sheet_list_screen.dart' as _i14;

class AppRouter extends _i16.RootStackRouter {
  AppRouter([_i17.GlobalKey<_i17.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MainScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ActivityRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    CreateSheetRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    SheetListRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    HomeScreen.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.HomeScreen(),
      );
    },
    DetailSheetRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    DetailSheet.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.DetailSheet(),
      );
    },
    ReadSheetRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ReviewSheetRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.ReviewSheet(),
      );
    },
    CreateReviewRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.CreateReview(),
      );
    },
    ReadSheet.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.ReadSheet(),
      );
    },
    AskQuestionRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.AskQuestion(),
      );
    },
    ActivityScreen.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.ActivityScreen(),
      );
    },
    CreateSheetScreen.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.CreateSheetScreen(),
      );
    },
    CreateDetailSheetRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.CreateDetailSheet(),
      );
    },
    SheetListScreen.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.SheetListScreen(),
      );
    },
    ProfileScreen.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.ProfileScreen(),
      );
    },
  };

  @override
  List<_i16.RouteConfig> get routes => [
        _i16.RouteConfig(
          MainScreen.name,
          path: '/',
          children: [
            _i16.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainScreen.name,
              children: [
                _i16.RouteConfig(
                  HomeScreen.name,
                  path: '',
                  parent: HomeRoute.name,
                ),
                _i16.RouteConfig(
                  DetailSheetRoute.name,
                  path: 'detail_sheet',
                  parent: HomeRoute.name,
                  children: [
                    _i16.RouteConfig(
                      DetailSheet.name,
                      path: '',
                      parent: DetailSheetRoute.name,
                    ),
                    _i16.RouteConfig(
                      ReadSheetRoute.name,
                      path: 'read_sheet',
                      parent: DetailSheetRoute.name,
                      children: [
                        _i16.RouteConfig(
                          ReadSheet.name,
                          path: '',
                          parent: ReadSheetRoute.name,
                        ),
                        _i16.RouteConfig(
                          AskQuestionRoute.name,
                          path: 'ask_question',
                          parent: ReadSheetRoute.name,
                        ),
                      ],
                    ),
                    _i16.RouteConfig(
                      ReviewSheetRoute.name,
                      path: 'review_sheet',
                      parent: DetailSheetRoute.name,
                    ),
                    _i16.RouteConfig(
                      CreateReviewRoute.name,
                      path: 'create_review',
                      parent: DetailSheetRoute.name,
                    ),
                  ],
                ),
              ],
            ),
            _i16.RouteConfig(
              ActivityRoute.name,
              path: 'activity',
              parent: MainScreen.name,
              children: [
                _i16.RouteConfig(
                  ActivityScreen.name,
                  path: '',
                  parent: ActivityRoute.name,
                )
              ],
            ),
            _i16.RouteConfig(
              CreateSheetRoute.name,
              path: 'create_sheet',
              parent: MainScreen.name,
              children: [
                _i16.RouteConfig(
                  CreateSheetScreen.name,
                  path: '',
                  parent: CreateSheetRoute.name,
                ),
                _i16.RouteConfig(
                  CreateDetailSheetRoute.name,
                  path: 'create_detail_sheet',
                  parent: CreateSheetRoute.name,
                ),
              ],
            ),
            _i16.RouteConfig(
              SheetListRoute.name,
              path: 'sheet_list',
              parent: MainScreen.name,
              children: [
                _i16.RouteConfig(
                  SheetListScreen.name,
                  path: '',
                  parent: SheetListRoute.name,
                )
              ],
            ),
            _i16.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: MainScreen.name,
              children: [
                _i16.RouteConfig(
                  ProfileScreen.name,
                  path: '',
                  parent: ProfileRoute.name,
                )
              ],
            ),
          ],
        ),
        _i16.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i16.RouteConfig(
          RegisterRoute.name,
          path: '/register',
        ),
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreen extends _i16.PageRouteInfo<void> {
  const MainScreen({List<_i16.PageRouteInfo>? children})
      : super(
          MainScreen.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterRoute extends _i16.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class HomeRoute extends _i16.PageRouteInfo<void> {
  const HomeRoute({List<_i16.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ActivityRoute extends _i16.PageRouteInfo<void> {
  const ActivityRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ActivityRoute.name,
          path: 'activity',
          initialChildren: children,
        );

  static const String name = 'ActivityRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class CreateSheetRoute extends _i16.PageRouteInfo<void> {
  const CreateSheetRoute({List<_i16.PageRouteInfo>? children})
      : super(
          CreateSheetRoute.name,
          path: 'create_sheet',
          initialChildren: children,
        );

  static const String name = 'CreateSheetRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class SheetListRoute extends _i16.PageRouteInfo<void> {
  const SheetListRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SheetListRoute.name,
          path: 'sheet_list',
          initialChildren: children,
        );

  static const String name = 'SheetListRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ProfileRoute extends _i16.PageRouteInfo<void> {
  const ProfileRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i5.HomeScreen]
class HomeScreen extends _i16.PageRouteInfo<void> {
  const HomeScreen()
      : super(
          HomeScreen.name,
          path: '',
        );

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class DetailSheetRoute extends _i16.PageRouteInfo<void> {
  const DetailSheetRoute({List<_i16.PageRouteInfo>? children})
      : super(
          DetailSheetRoute.name,
          path: 'detail_sheet',
          initialChildren: children,
        );

  static const String name = 'DetailSheetRoute';
}

/// generated route for
/// [_i6.DetailSheet]
class DetailSheet extends _i16.PageRouteInfo<void> {
  const DetailSheet()
      : super(
          DetailSheet.name,
          path: '',
        );

  static const String name = 'DetailSheet';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ReadSheetRoute extends _i16.PageRouteInfo<void> {
  const ReadSheetRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ReadSheetRoute.name,
          path: 'read_sheet',
          initialChildren: children,
        );

  static const String name = 'ReadSheetRoute';
}

/// generated route for
/// [_i7.ReviewSheet]
class ReviewSheetRoute extends _i16.PageRouteInfo<void> {
  const ReviewSheetRoute()
      : super(
          ReviewSheetRoute.name,
          path: 'review_sheet',
        );

  static const String name = 'ReviewSheetRoute';
}

/// generated route for
/// [_i8.CreateReview]
class CreateReviewRoute extends _i16.PageRouteInfo<void> {
  const CreateReviewRoute()
      : super(
          CreateReviewRoute.name,
          path: 'create_review',
        );

  static const String name = 'CreateReviewRoute';
}

/// generated route for
/// [_i9.ReadSheet]
class ReadSheet extends _i16.PageRouteInfo<void> {
  const ReadSheet()
      : super(
          ReadSheet.name,
          path: '',
        );

  static const String name = 'ReadSheet';
}

/// generated route for
/// [_i10.AskQuestion]
class AskQuestionRoute extends _i16.PageRouteInfo<void> {
  const AskQuestionRoute()
      : super(
          AskQuestionRoute.name,
          path: 'ask_question',
        );

  static const String name = 'AskQuestionRoute';
}

/// generated route for
/// [_i11.ActivityScreen]
class ActivityScreen extends _i16.PageRouteInfo<void> {
  const ActivityScreen()
      : super(
          ActivityScreen.name,
          path: '',
        );

  static const String name = 'ActivityScreen';
}

/// generated route for
/// [_i12.CreateSheetScreen]
class CreateSheetScreen extends _i16.PageRouteInfo<void> {
  const CreateSheetScreen()
      : super(
          CreateSheetScreen.name,
          path: '',
        );

  static const String name = 'CreateSheetScreen';
}

/// generated route for
/// [_i13.CreateDetailSheet]
class CreateDetailSheetRoute extends _i16.PageRouteInfo<void> {
  const CreateDetailSheetRoute()
      : super(
          CreateDetailSheetRoute.name,
          path: 'create_detail_sheet',
        );

  static const String name = 'CreateDetailSheetRoute';
}

/// generated route for
/// [_i14.SheetListScreen]
class SheetListScreen extends _i16.PageRouteInfo<void> {
  const SheetListScreen()
      : super(
          SheetListScreen.name,
          path: '',
        );

  static const String name = 'SheetListScreen';
}

/// generated route for
/// [_i15.ProfileScreen]
class ProfileScreen extends _i16.PageRouteInfo<void> {
  const ProfileScreen()
      : super(
          ProfileScreen.name,
          path: '',
        );

  static const String name = 'ProfileScreen';
}
