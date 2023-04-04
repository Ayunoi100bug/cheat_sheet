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
import 'dart:ui' as _i38;

import 'package:auto_route/auto_route.dart' as _i36;
import 'package:auto_route/empty_router_widgets.dart' as _i5;
import 'package:flutter/material.dart' as _i37;
import 'package:painter/painter.dart' as _i39;
import 'package:pdf_render/pdf_render.dart' as _i40;

import '../../res/components/tools_bar/color_picker_page.dart' as _i15;
import '../../view/about_grade.dart' as _i35;
import '../../view/about_subject.dart' as _i34;
import '../../view/activity_screen/activity_screen.dart' as _i21;
import '../../view/activity_screen/all_achievement.dart' as _i22;
import '../../view/create_sheet_screen/create_detail_sheet.dart' as _i24;
import '../../view/create_sheet_screen/import_sheet_screen.dart' as _i23;
import '../../view/create_sheet_screen/pick_demo_pages.dart' as _i26;
import '../../view/create_sheet_screen/view_import_sheet.dart' as _i25;
import '../../view/home_screen/create_review.dart' as _i18;
import '../../view/home_screen/detail_sheet.dart' as _i11;
import '../../view/home_screen/edit_sheet.dart' as _i19;
import '../../view/home_screen/home_screen.dart' as _i7;
import '../../view/home_screen/other_profile.dart' as _i10;
import '../../view/home_screen/question/ask_question.dart' as _i13;
import '../../view/home_screen/question/create_question.dart' as _i14;
import '../../view/home_screen/question/detail_question.dart' as _i16;
import '../../view/home_screen/question/edit_demo.dart' as _i20;
import '../../view/home_screen/read_sheet.dart' as _i12;
import '../../view/home_screen/review_sheet.dart' as _i17;
import '../../view/home_screen/searching_sheet.dart' as _i9;
import '../../view/login.dart' as _i2;
import '../../view/main_screen.dart' as _i1;
import '../../view/profile_screen/edit_profile.dart' as _i30;
import '../../view/profile_screen/profile_screen.dart' as _i29;
import '../../view/register.dart' as _i3;
import '../../view/sheet_list_screen/sheet_list_detail.dart' as _i28;
import '../../view/sheet_list_screen/sheet_list_screen.dart' as _i27;
import '../../view/side_bar_menu/my_account/change_email.dart' as _i32;
import '../../view/side_bar_menu/my_account/change_password.dart' as _i33;
import '../../view/side_bar_menu/my_account/my_account.dart' as _i31;
import '../../view/side_bar_menu/notification_setting.dart' as _i4;
import '../../view/side_bar_menu/top_up.dart' as _i6;
import '../../view/test_ui_book.dart' as _i8;

class AppRouter extends _i36.RootStackRouter {
  AppRouter([_i37.GlobalKey<_i37.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i36.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MainScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterScreen(),
      );
    },
    NotificationSettingRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.NotificationSetting(),
      );
    },
    MyAccountRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    TopUpRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.TopUp(),
      );
    },
    FirstLoginRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    ActivityRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    CreateSheetRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    SheetListRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.HomeScreen(),
      );
    },
    TestUIRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.TestUIPage(),
      );
    },
    SearchingSheetRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.SearchingSheet(),
      );
    },
    OtherProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<OtherProfileRouteArgs>(
          orElse: () =>
              OtherProfileRouteArgs(userId: pathParams.getString('userId')));
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.OtherProfile(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    DetailSheetRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DetailSheetRouteArgs>(
          orElse: () =>
              DetailSheetRouteArgs(sheetId: pathParams.getString('sheetId')));
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.DetailSheet(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    ReadSheetRoute.name: (routeData) {
      final args = routeData.argsAs<ReadSheetRouteArgs>();
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.ReadSheet(
          key: args.key,
          sheetId: args.sheetId,
          sheetTitle: args.sheetTitle,
        ),
      );
    },
    AskQuestionRoute.name: (routeData) {
      final args = routeData.argsAs<AskQuestionRouteArgs>();
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.AskQuestion(
          key: args.key,
          sheetId: args.sheetId,
          askingPage: args.askingPage,
        ),
      );
    },
    CreateQuestionRoute.name: (routeData) {
      final args = routeData.argsAs<CreateQuestionRouteArgs>();
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.CreateQuestion(
          key: args.key,
          sheetId: args.sheetId,
          askingPage: args.askingPage,
        ),
      );
    },
    PickColorRoute.name: (routeData) {
      final args = routeData.argsAs<PickColorRouteArgs>();
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.ColorPickerPage(
          key: args.key,
          pickedColor: args.pickedColor,
          controller: args.controller,
        ),
      );
    },
    DetailQuestionRoute.name: (routeData) {
      final args = routeData.argsAs<DetailQuestionRouteArgs>();
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.DetailQuestion(
          key: args.key,
          sheetId: args.sheetId,
          questionId: args.questionId,
          askingPage: args.askingPage,
        ),
      );
    },
    ReviewSheetRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ReviewSheetRouteArgs>(
          orElse: () =>
              ReviewSheetRouteArgs(sheetId: pathParams.getString('sheetId')));
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.ReviewSheet(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    CreateReviewRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CreateReviewRouteArgs>(
          orElse: () =>
              CreateReviewRouteArgs(sheetId: pathParams.getString('sheetId')));
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i18.CreateReview(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    EditSheetRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditSheetRouteArgs>(
          orElse: () =>
              EditSheetRouteArgs(sheetId: pathParams.getString('sheetId')));
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i19.EditSheet(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    EditDemoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditDemoRouteArgs>(
          orElse: () =>
              EditDemoRouteArgs(sheetId: pathParams.getString('sheetId')));
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i20.EditDemo(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    ActivityScreen.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i21.ActivityScreen(),
      );
    },
    AllAchievementRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i22.AllAchievement(),
      );
    },
    CreateSheetScreen.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i23.CreateSheetScreen(),
      );
    },
    CreateDetailSheetRoute.name: (routeData) {
      final args = routeData.argsAs<CreateDetailSheetRouteArgs>();
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i24.CreateDetailSheet(
          key: args.key,
          demoPages: args.demoPages,
        ),
      );
    },
    ViewImportSheetRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i25.ViewImportSheet(),
      );
    },
    PickDemoPagesRoute.name: (routeData) {
      final args = routeData.argsAs<PickDemoPagesRouteArgs>();
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i26.PickDemoPages(
          key: args.key,
          doc: args.doc,
          pagesNumber: args.pagesNumber,
        ),
      );
    },
    SheetListScreen.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i27.SheetListScreen(),
      );
    },
    SheetListDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SheetListDetailRouteArgs>(
          orElse: () => SheetListDetailRouteArgs(
              sheetId: pathParams.getString('sheetId')));
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i28.SheetListDetail(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    ProfileScreen.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i29.ProfileScreen(),
      );
    },
    EditProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditProfileRouteArgs>(
          orElse: () =>
              EditProfileRouteArgs(userId: pathParams.getString('userId')));
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i30.EditProfile(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    MyAccount.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i31.MyAccount(),
      );
    },
    ChangeEmailRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i32.ChangeEmail(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i33.ChangePassword(),
      );
    },
    AboutSubjectRoute.name: (routeData) {
      final args = routeData.argsAs<AboutSubjectRouteArgs>();
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i34.AboutSubject(
          key: args.key,
          grade: args.grade,
        ),
      );
    },
    AboutGradeRoute.name: (routeData) {
      return _i36.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i35.AboutGrade(),
      );
    },
  };

  @override
  List<_i36.RouteConfig> get routes => [
        _i36.RouteConfig(
          MainScreen.name,
          path: '/',
          children: [
            _i36.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainScreen.name,
              children: [
                _i36.RouteConfig(
                  HomeScreenRoute.name,
                  path: '',
                  parent: HomeRoute.name,
                ),
                _i36.RouteConfig(
                  TestUIRoute.name,
                  path: 'test_ui',
                  parent: HomeRoute.name,
                ),
                _i36.RouteConfig(
                  SearchingSheetRoute.name,
                  path: 'searching',
                  parent: HomeRoute.name,
                ),
                _i36.RouteConfig(
                  OtherProfileRoute.name,
                  path: 'other_profile/:userId',
                  parent: HomeRoute.name,
                ),
                _i36.RouteConfig(
                  DetailSheetRoute.name,
                  path: ':sheetId',
                  parent: HomeRoute.name,
                ),
                _i36.RouteConfig(
                  ReadSheetRoute.name,
                  path: ':sheetId/read_sheet',
                  parent: HomeRoute.name,
                ),
                _i36.RouteConfig(
                  AskQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question',
                  parent: HomeRoute.name,
                ),
                _i36.RouteConfig(
                  CreateQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question/create_question',
                  parent: HomeRoute.name,
                ),
                _i36.RouteConfig(
                  PickColorRoute.name,
                  path:
                      ':sheetId/read_sheet/ask_question/create_question/pick_color',
                  parent: HomeRoute.name,
                ),
                _i36.RouteConfig(
                  DetailQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question/:questionId',
                  parent: HomeRoute.name,
                ),
                _i36.RouteConfig(
                  ReviewSheetRoute.name,
                  path: ':sheetId/review_sheet',
                  parent: HomeRoute.name,
                ),
                _i36.RouteConfig(
                  CreateReviewRoute.name,
                  path: ':sheetId/create_review',
                  parent: HomeRoute.name,
                ),
                _i36.RouteConfig(
                  EditSheetRoute.name,
                  path: ':sheetId/edit_sheet',
                  parent: HomeRoute.name,
                ),
                _i36.RouteConfig(
                  EditDemoRoute.name,
                  path: ':sheetId/edit_sheet/edit_demo',
                  parent: HomeRoute.name,
                ),
              ],
            ),
            _i36.RouteConfig(
              ActivityRoute.name,
              path: 'activity',
              parent: MainScreen.name,
              children: [
                _i36.RouteConfig(
                  ActivityScreen.name,
                  path: '',
                  parent: ActivityRoute.name,
                ),
                _i36.RouteConfig(
                  AllAchievementRoute.name,
                  path: 'all_achievement',
                  parent: ActivityRoute.name,
                ),
              ],
            ),
            _i36.RouteConfig(
              CreateSheetRoute.name,
              path: 'create_sheet',
              parent: MainScreen.name,
              children: [
                _i36.RouteConfig(
                  CreateSheetScreen.name,
                  path: '',
                  parent: CreateSheetRoute.name,
                ),
                _i36.RouteConfig(
                  CreateDetailSheetRoute.name,
                  path: 'create_detail_sheet',
                  parent: CreateSheetRoute.name,
                ),
                _i36.RouteConfig(
                  ViewImportSheetRoute.name,
                  path: 'view_import_sheet',
                  parent: CreateSheetRoute.name,
                ),
                _i36.RouteConfig(
                  PickDemoPagesRoute.name,
                  path: 'pick_demo_pages',
                  parent: CreateSheetRoute.name,
                ),
              ],
            ),
            _i36.RouteConfig(
              SheetListRoute.name,
              path: 'sheet_list',
              parent: MainScreen.name,
              children: [
                _i36.RouteConfig(
                  SheetListScreen.name,
                  path: '',
                  parent: SheetListRoute.name,
                ),
                _i36.RouteConfig(
                  SheetListDetailRoute.name,
                  path: ':sheetId',
                  parent: SheetListRoute.name,
                ),
              ],
            ),
            _i36.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: MainScreen.name,
              children: [
                _i36.RouteConfig(
                  ProfileScreen.name,
                  path: '',
                  parent: ProfileRoute.name,
                ),
                _i36.RouteConfig(
                  EditProfileRoute.name,
                  path: ':userId',
                  parent: ProfileRoute.name,
                ),
              ],
            ),
          ],
        ),
        _i36.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i36.RouteConfig(
          RegisterRoute.name,
          path: '/register',
        ),
        _i36.RouteConfig(
          NotificationSettingRoute.name,
          path: '/notification_setting',
        ),
        _i36.RouteConfig(
          MyAccountRoute.name,
          path: '/my_account',
          children: [
            _i36.RouteConfig(
              MyAccount.name,
              path: '',
              parent: MyAccountRoute.name,
            ),
            _i36.RouteConfig(
              ChangeEmailRoute.name,
              path: 'change_email',
              parent: MyAccountRoute.name,
            ),
            _i36.RouteConfig(
              ChangePasswordRoute.name,
              path: 'change_password',
              parent: MyAccountRoute.name,
            ),
          ],
        ),
        _i36.RouteConfig(
          TopUpRoute.name,
          path: '/top_up',
        ),
        _i36.RouteConfig(
          FirstLoginRoute.name,
          path: '/first_login',
          children: [
            _i36.RouteConfig(
              '#redirect',
              path: '',
              parent: FirstLoginRoute.name,
              redirectTo: 'about_grade',
              fullMatch: true,
            ),
            _i36.RouteConfig(
              AboutSubjectRoute.name,
              path: 'about_subject',
              parent: FirstLoginRoute.name,
            ),
            _i36.RouteConfig(
              AboutGradeRoute.name,
              path: 'about_grade',
              parent: FirstLoginRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreen extends _i36.PageRouteInfo<void> {
  const MainScreen({List<_i36.PageRouteInfo>? children})
      : super(
          MainScreen.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i36.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterRoute extends _i36.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i4.NotificationSetting]
class NotificationSettingRoute extends _i36.PageRouteInfo<void> {
  const NotificationSettingRoute()
      : super(
          NotificationSettingRoute.name,
          path: '/notification_setting',
        );

  static const String name = 'NotificationSettingRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class MyAccountRoute extends _i36.PageRouteInfo<void> {
  const MyAccountRoute({List<_i36.PageRouteInfo>? children})
      : super(
          MyAccountRoute.name,
          path: '/my_account',
          initialChildren: children,
        );

  static const String name = 'MyAccountRoute';
}

/// generated route for
/// [_i6.TopUp]
class TopUpRoute extends _i36.PageRouteInfo<void> {
  const TopUpRoute()
      : super(
          TopUpRoute.name,
          path: '/top_up',
        );

  static const String name = 'TopUpRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class FirstLoginRoute extends _i36.PageRouteInfo<void> {
  const FirstLoginRoute({List<_i36.PageRouteInfo>? children})
      : super(
          FirstLoginRoute.name,
          path: '/first_login',
          initialChildren: children,
        );

  static const String name = 'FirstLoginRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class HomeRoute extends _i36.PageRouteInfo<void> {
  const HomeRoute({List<_i36.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class ActivityRoute extends _i36.PageRouteInfo<void> {
  const ActivityRoute({List<_i36.PageRouteInfo>? children})
      : super(
          ActivityRoute.name,
          path: 'activity',
          initialChildren: children,
        );

  static const String name = 'ActivityRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class CreateSheetRoute extends _i36.PageRouteInfo<void> {
  const CreateSheetRoute({List<_i36.PageRouteInfo>? children})
      : super(
          CreateSheetRoute.name,
          path: 'create_sheet',
          initialChildren: children,
        );

  static const String name = 'CreateSheetRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class SheetListRoute extends _i36.PageRouteInfo<void> {
  const SheetListRoute({List<_i36.PageRouteInfo>? children})
      : super(
          SheetListRoute.name,
          path: 'sheet_list',
          initialChildren: children,
        );

  static const String name = 'SheetListRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class ProfileRoute extends _i36.PageRouteInfo<void> {
  const ProfileRoute({List<_i36.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i7.HomeScreen]
class HomeScreenRoute extends _i36.PageRouteInfo<void> {
  const HomeScreenRoute()
      : super(
          HomeScreenRoute.name,
          path: '',
        );

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i8.TestUIPage]
class TestUIRoute extends _i36.PageRouteInfo<void> {
  const TestUIRoute()
      : super(
          TestUIRoute.name,
          path: 'test_ui',
        );

  static const String name = 'TestUIRoute';
}

/// generated route for
/// [_i9.SearchingSheet]
class SearchingSheetRoute extends _i36.PageRouteInfo<void> {
  const SearchingSheetRoute()
      : super(
          SearchingSheetRoute.name,
          path: 'searching',
        );

  static const String name = 'SearchingSheetRoute';
}

/// generated route for
/// [_i10.OtherProfile]
class OtherProfileRoute extends _i36.PageRouteInfo<OtherProfileRouteArgs> {
  OtherProfileRoute({
    _i37.Key? key,
    required String userId,
  }) : super(
          OtherProfileRoute.name,
          path: 'other_profile/:userId',
          args: OtherProfileRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'userId': userId},
        );

  static const String name = 'OtherProfileRoute';
}

class OtherProfileRouteArgs {
  const OtherProfileRouteArgs({
    this.key,
    required this.userId,
  });

  final _i37.Key? key;

  final String userId;

  @override
  String toString() {
    return 'OtherProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i11.DetailSheet]
class DetailSheetRoute extends _i36.PageRouteInfo<DetailSheetRouteArgs> {
  DetailSheetRoute({
    _i37.Key? key,
    required String sheetId,
  }) : super(
          DetailSheetRoute.name,
          path: ':sheetId',
          args: DetailSheetRouteArgs(
            key: key,
            sheetId: sheetId,
          ),
          rawPathParams: {'sheetId': sheetId},
        );

  static const String name = 'DetailSheetRoute';
}

class DetailSheetRouteArgs {
  const DetailSheetRouteArgs({
    this.key,
    required this.sheetId,
  });

  final _i37.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'DetailSheetRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i12.ReadSheet]
class ReadSheetRoute extends _i36.PageRouteInfo<ReadSheetRouteArgs> {
  ReadSheetRoute({
    _i37.Key? key,
    required String sheetId,
    required String sheetTitle,
  }) : super(
          ReadSheetRoute.name,
          path: ':sheetId/read_sheet',
          args: ReadSheetRouteArgs(
            key: key,
            sheetId: sheetId,
            sheetTitle: sheetTitle,
          ),
          rawPathParams: {'sheetId': sheetId},
        );

  static const String name = 'ReadSheetRoute';
}

class ReadSheetRouteArgs {
  const ReadSheetRouteArgs({
    this.key,
    required this.sheetId,
    required this.sheetTitle,
  });

  final _i37.Key? key;

  final String sheetId;

  final String sheetTitle;

  @override
  String toString() {
    return 'ReadSheetRouteArgs{key: $key, sheetId: $sheetId, sheetTitle: $sheetTitle}';
  }
}

/// generated route for
/// [_i13.AskQuestion]
class AskQuestionRoute extends _i36.PageRouteInfo<AskQuestionRouteArgs> {
  AskQuestionRoute({
    _i37.Key? key,
    required String sheetId,
    required int askingPage,
  }) : super(
          AskQuestionRoute.name,
          path: ':sheetId/read_sheet/ask_question',
          args: AskQuestionRouteArgs(
            key: key,
            sheetId: sheetId,
            askingPage: askingPage,
          ),
          rawPathParams: {'sheetId': sheetId},
        );

  static const String name = 'AskQuestionRoute';
}

class AskQuestionRouteArgs {
  const AskQuestionRouteArgs({
    this.key,
    required this.sheetId,
    required this.askingPage,
  });

  final _i37.Key? key;

  final String sheetId;

  final int askingPage;

  @override
  String toString() {
    return 'AskQuestionRouteArgs{key: $key, sheetId: $sheetId, askingPage: $askingPage}';
  }
}

/// generated route for
/// [_i14.CreateQuestion]
class CreateQuestionRoute extends _i36.PageRouteInfo<CreateQuestionRouteArgs> {
  CreateQuestionRoute({
    _i37.Key? key,
    required String sheetId,
    required int askingPage,
  }) : super(
          CreateQuestionRoute.name,
          path: ':sheetId/read_sheet/ask_question/create_question',
          args: CreateQuestionRouteArgs(
            key: key,
            sheetId: sheetId,
            askingPage: askingPage,
          ),
        );

  static const String name = 'CreateQuestionRoute';
}

class CreateQuestionRouteArgs {
  const CreateQuestionRouteArgs({
    this.key,
    required this.sheetId,
    required this.askingPage,
  });

  final _i37.Key? key;

  final String sheetId;

  final int askingPage;

  @override
  String toString() {
    return 'CreateQuestionRouteArgs{key: $key, sheetId: $sheetId, askingPage: $askingPage}';
  }
}

/// generated route for
/// [_i15.ColorPickerPage]
class PickColorRoute extends _i36.PageRouteInfo<PickColorRouteArgs> {
  PickColorRoute({
    _i37.Key? key,
    required _i38.Color pickedColor,
    required _i39.PainterController controller,
  }) : super(
          PickColorRoute.name,
          path: ':sheetId/read_sheet/ask_question/create_question/pick_color',
          args: PickColorRouteArgs(
            key: key,
            pickedColor: pickedColor,
            controller: controller,
          ),
        );

  static const String name = 'PickColorRoute';
}

class PickColorRouteArgs {
  const PickColorRouteArgs({
    this.key,
    required this.pickedColor,
    required this.controller,
  });

  final _i37.Key? key;

  final _i38.Color pickedColor;

  final _i39.PainterController controller;

  @override
  String toString() {
    return 'PickColorRouteArgs{key: $key, pickedColor: $pickedColor, controller: $controller}';
  }
}

/// generated route for
/// [_i16.DetailQuestion]
class DetailQuestionRoute extends _i36.PageRouteInfo<DetailQuestionRouteArgs> {
  DetailQuestionRoute({
    _i37.Key? key,
    required String sheetId,
    required String questionId,
    required int askingPage,
  }) : super(
          DetailQuestionRoute.name,
          path: ':sheetId/read_sheet/ask_question/:questionId',
          args: DetailQuestionRouteArgs(
            key: key,
            sheetId: sheetId,
            questionId: questionId,
            askingPage: askingPage,
          ),
          rawPathParams: {
            'sheetId': sheetId,
            'questionId': questionId,
          },
        );

  static const String name = 'DetailQuestionRoute';
}

class DetailQuestionRouteArgs {
  const DetailQuestionRouteArgs({
    this.key,
    required this.sheetId,
    required this.questionId,
    required this.askingPage,
  });

  final _i37.Key? key;

  final String sheetId;

  final String questionId;

  final int askingPage;

  @override
  String toString() {
    return 'DetailQuestionRouteArgs{key: $key, sheetId: $sheetId, questionId: $questionId, askingPage: $askingPage}';
  }
}

/// generated route for
/// [_i17.ReviewSheet]
class ReviewSheetRoute extends _i36.PageRouteInfo<ReviewSheetRouteArgs> {
  ReviewSheetRoute({
    _i37.Key? key,
    required String sheetId,
  }) : super(
          ReviewSheetRoute.name,
          path: ':sheetId/review_sheet',
          args: ReviewSheetRouteArgs(
            key: key,
            sheetId: sheetId,
          ),
          rawPathParams: {'sheetId': sheetId},
        );

  static const String name = 'ReviewSheetRoute';
}

class ReviewSheetRouteArgs {
  const ReviewSheetRouteArgs({
    this.key,
    required this.sheetId,
  });

  final _i37.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'ReviewSheetRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i18.CreateReview]
class CreateReviewRoute extends _i36.PageRouteInfo<CreateReviewRouteArgs> {
  CreateReviewRoute({
    _i37.Key? key,
    required String sheetId,
  }) : super(
          CreateReviewRoute.name,
          path: ':sheetId/create_review',
          args: CreateReviewRouteArgs(
            key: key,
            sheetId: sheetId,
          ),
          rawPathParams: {'sheetId': sheetId},
        );

  static const String name = 'CreateReviewRoute';
}

class CreateReviewRouteArgs {
  const CreateReviewRouteArgs({
    this.key,
    required this.sheetId,
  });

  final _i37.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'CreateReviewRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i19.EditSheet]
class EditSheetRoute extends _i36.PageRouteInfo<EditSheetRouteArgs> {
  EditSheetRoute({
    _i37.Key? key,
    required String sheetId,
  }) : super(
          EditSheetRoute.name,
          path: ':sheetId/edit_sheet',
          args: EditSheetRouteArgs(
            key: key,
            sheetId: sheetId,
          ),
          rawPathParams: {'sheetId': sheetId},
        );

  static const String name = 'EditSheetRoute';
}

class EditSheetRouteArgs {
  const EditSheetRouteArgs({
    this.key,
    required this.sheetId,
  });

  final _i37.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'EditSheetRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i20.EditDemo]
class EditDemoRoute extends _i36.PageRouteInfo<EditDemoRouteArgs> {
  EditDemoRoute({
    _i37.Key? key,
    required String sheetId,
  }) : super(
          EditDemoRoute.name,
          path: ':sheetId/edit_sheet/edit_demo',
          args: EditDemoRouteArgs(
            key: key,
            sheetId: sheetId,
          ),
          rawPathParams: {'sheetId': sheetId},
        );

  static const String name = 'EditDemoRoute';
}

class EditDemoRouteArgs {
  const EditDemoRouteArgs({
    this.key,
    required this.sheetId,
  });

  final _i37.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'EditDemoRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i21.ActivityScreen]
class ActivityScreen extends _i36.PageRouteInfo<void> {
  const ActivityScreen()
      : super(
          ActivityScreen.name,
          path: '',
        );

  static const String name = 'ActivityScreen';
}

/// generated route for
/// [_i22.AllAchievement]
class AllAchievementRoute extends _i36.PageRouteInfo<void> {
  const AllAchievementRoute()
      : super(
          AllAchievementRoute.name,
          path: 'all_achievement',
        );

  static const String name = 'AllAchievementRoute';
}

/// generated route for
/// [_i23.CreateSheetScreen]
class CreateSheetScreen extends _i36.PageRouteInfo<void> {
  const CreateSheetScreen()
      : super(
          CreateSheetScreen.name,
          path: '',
        );

  static const String name = 'CreateSheetScreen';
}

/// generated route for
/// [_i24.CreateDetailSheet]
class CreateDetailSheetRoute
    extends _i36.PageRouteInfo<CreateDetailSheetRouteArgs> {
  CreateDetailSheetRoute({
    _i37.Key? key,
    required List<int> demoPages,
  }) : super(
          CreateDetailSheetRoute.name,
          path: 'create_detail_sheet',
          args: CreateDetailSheetRouteArgs(
            key: key,
            demoPages: demoPages,
          ),
        );

  static const String name = 'CreateDetailSheetRoute';
}

class CreateDetailSheetRouteArgs {
  const CreateDetailSheetRouteArgs({
    this.key,
    required this.demoPages,
  });

  final _i37.Key? key;

  final List<int> demoPages;

  @override
  String toString() {
    return 'CreateDetailSheetRouteArgs{key: $key, demoPages: $demoPages}';
  }
}

/// generated route for
/// [_i25.ViewImportSheet]
class ViewImportSheetRoute extends _i36.PageRouteInfo<void> {
  const ViewImportSheetRoute()
      : super(
          ViewImportSheetRoute.name,
          path: 'view_import_sheet',
        );

  static const String name = 'ViewImportSheetRoute';
}

/// generated route for
/// [_i26.PickDemoPages]
class PickDemoPagesRoute extends _i36.PageRouteInfo<PickDemoPagesRouteArgs> {
  PickDemoPagesRoute({
    _i37.Key? key,
    required _i40.PdfDocument doc,
    required int pagesNumber,
  }) : super(
          PickDemoPagesRoute.name,
          path: 'pick_demo_pages',
          args: PickDemoPagesRouteArgs(
            key: key,
            doc: doc,
            pagesNumber: pagesNumber,
          ),
        );

  static const String name = 'PickDemoPagesRoute';
}

class PickDemoPagesRouteArgs {
  const PickDemoPagesRouteArgs({
    this.key,
    required this.doc,
    required this.pagesNumber,
  });

  final _i37.Key? key;

  final _i40.PdfDocument doc;

  final int pagesNumber;

  @override
  String toString() {
    return 'PickDemoPagesRouteArgs{key: $key, doc: $doc, pagesNumber: $pagesNumber}';
  }
}

/// generated route for
/// [_i27.SheetListScreen]
class SheetListScreen extends _i36.PageRouteInfo<void> {
  const SheetListScreen()
      : super(
          SheetListScreen.name,
          path: '',
        );

  static const String name = 'SheetListScreen';
}

/// generated route for
/// [_i28.SheetListDetail]
class SheetListDetailRoute
    extends _i36.PageRouteInfo<SheetListDetailRouteArgs> {
  SheetListDetailRoute({
    _i37.Key? key,
    required String sheetId,
  }) : super(
          SheetListDetailRoute.name,
          path: ':sheetId',
          args: SheetListDetailRouteArgs(
            key: key,
            sheetId: sheetId,
          ),
          rawPathParams: {'sheetId': sheetId},
        );

  static const String name = 'SheetListDetailRoute';
}

class SheetListDetailRouteArgs {
  const SheetListDetailRouteArgs({
    this.key,
    required this.sheetId,
  });

  final _i37.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'SheetListDetailRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i29.ProfileScreen]
class ProfileScreen extends _i36.PageRouteInfo<void> {
  const ProfileScreen()
      : super(
          ProfileScreen.name,
          path: '',
        );

  static const String name = 'ProfileScreen';
}

/// generated route for
/// [_i30.EditProfile]
class EditProfileRoute extends _i36.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i37.Key? key,
    required String userId,
  }) : super(
          EditProfileRoute.name,
          path: ':userId',
          args: EditProfileRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'userId': userId},
        );

  static const String name = 'EditProfileRoute';
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.userId,
  });

  final _i37.Key? key;

  final String userId;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i31.MyAccount]
class MyAccount extends _i36.PageRouteInfo<void> {
  const MyAccount()
      : super(
          MyAccount.name,
          path: '',
        );

  static const String name = 'MyAccount';
}

/// generated route for
/// [_i32.ChangeEmail]
class ChangeEmailRoute extends _i36.PageRouteInfo<void> {
  const ChangeEmailRoute()
      : super(
          ChangeEmailRoute.name,
          path: 'change_email',
        );

  static const String name = 'ChangeEmailRoute';
}

/// generated route for
/// [_i33.ChangePassword]
class ChangePasswordRoute extends _i36.PageRouteInfo<void> {
  const ChangePasswordRoute()
      : super(
          ChangePasswordRoute.name,
          path: 'change_password',
        );

  static const String name = 'ChangePasswordRoute';
}

/// generated route for
/// [_i34.AboutSubject]
class AboutSubjectRoute extends _i36.PageRouteInfo<AboutSubjectRouteArgs> {
  AboutSubjectRoute({
    _i37.Key? key,
    required String grade,
  }) : super(
          AboutSubjectRoute.name,
          path: 'about_subject',
          args: AboutSubjectRouteArgs(
            key: key,
            grade: grade,
          ),
        );

  static const String name = 'AboutSubjectRoute';
}

class AboutSubjectRouteArgs {
  const AboutSubjectRouteArgs({
    this.key,
    required this.grade,
  });

  final _i37.Key? key;

  final String grade;

  @override
  String toString() {
    return 'AboutSubjectRouteArgs{key: $key, grade: $grade}';
  }
}

/// generated route for
/// [_i35.AboutGrade]
class AboutGradeRoute extends _i36.PageRouteInfo<void> {
  const AboutGradeRoute()
      : super(
          AboutGradeRoute.name,
          path: 'about_grade',
        );

  static const String name = 'AboutGradeRoute';
}
