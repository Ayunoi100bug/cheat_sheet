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
import 'dart:ui' as _i39;

import 'package:auto_route/auto_route.dart' as _i37;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:flutter/material.dart' as _i38;
import 'package:painter/painter.dart' as _i40;
import 'package:pdf_render/pdf_render.dart' as _i41;

import '../../res/components/tools_bar/color_picker_page.dart' as _i16;
import '../../view/about_grade.dart' as _i36;
import '../../view/about_subject.dart' as _i35;
import '../../view/activity_screen/activity_screen.dart' as _i22;
import '../../view/activity_screen/all_achievement.dart' as _i23;
import '../../view/create_sheet_screen/create_detail_sheet.dart' as _i25;
import '../../view/create_sheet_screen/import_sheet_screen.dart' as _i24;
import '../../view/create_sheet_screen/pick_demo_pages.dart' as _i27;
import '../../view/create_sheet_screen/view_import_sheet.dart' as _i26;
import '../../view/home_screen/create_review.dart' as _i19;
import '../../view/home_screen/detail_sheet.dart' as _i12;
import '../../view/home_screen/edit_sheet.dart' as _i20;
import '../../view/home_screen/home_screen.dart' as _i6;
import '../../view/home_screen/other_profile.dart' as _i11;
import '../../view/home_screen/question/ask_question.dart' as _i14;
import '../../view/home_screen/question/create_question.dart' as _i15;
import '../../view/home_screen/question/detail_question.dart' as _i17;
import '../../view/home_screen/question/edit_demo.dart' as _i21;
import '../../view/home_screen/read_sheet.dart' as _i13;
import '../../view/home_screen/recommend_sheet.dart' as _i9;
import '../../view/home_screen/review_sheet.dart' as _i18;
import '../../view/home_screen/searching_sheet.dart' as _i8;
import '../../view/home_screen/top_sheet.dart' as _i10;
import '../../view/login.dart' as _i2;
import '../../view/main_screen.dart' as _i1;
import '../../view/profile_screen/edit_profile.dart' as _i31;
import '../../view/profile_screen/profile_screen.dart' as _i30;
import '../../view/register.dart' as _i3;
import '../../view/sheet_list_screen/sheet_list_detail.dart' as _i29;
import '../../view/sheet_list_screen/sheet_list_screen.dart' as _i28;
import '../../view/side_bar_menu/my_account/change_email.dart' as _i33;
import '../../view/side_bar_menu/my_account/change_password.dart' as _i34;
import '../../view/side_bar_menu/my_account/my_account.dart' as _i32;
import '../../view/side_bar_menu/top_up.dart' as _i5;
import '../../view/test_ui_book.dart' as _i7;

class AppRouter extends _i37.RootStackRouter {
  AppRouter([_i38.GlobalKey<_i38.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i37.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MainScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterScreen(),
      );
    },
    MyAccountRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    TopUpRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.TopUp(),
      );
    },
    FirstLoginRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ActivityRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    CreateSheetRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    SheetListRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.HomeScreen(),
      );
    },
    TestUIRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.TestUIPage(),
      );
    },
    SearchingSheetRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.SearchingSheet(),
      );
    },
    RecommendSheetRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.RecommendSheet(),
      );
    },
    TopSheetRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.TopSheet(),
      );
    },
    OtherProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<OtherProfileRouteArgs>(
          orElse: () =>
              OtherProfileRouteArgs(userId: pathParams.getString('userId')));
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.OtherProfile(
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
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.DetailSheet(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    ReadSheetRoute.name: (routeData) {
      final args = routeData.argsAs<ReadSheetRouteArgs>();
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.ReadSheet(
          key: args.key,
          sheetId: args.sheetId,
          sheetTitle: args.sheetTitle,
        ),
      );
    },
    AskQuestionRoute.name: (routeData) {
      final args = routeData.argsAs<AskQuestionRouteArgs>();
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.AskQuestion(
          key: args.key,
          sheetId: args.sheetId,
          askingPage: args.askingPage,
        ),
      );
    },
    CreateQuestionRoute.name: (routeData) {
      final args = routeData.argsAs<CreateQuestionRouteArgs>();
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.CreateQuestion(
          key: args.key,
          sheetId: args.sheetId,
          askingPage: args.askingPage,
        ),
      );
    },
    PickColorRoute.name: (routeData) {
      final args = routeData.argsAs<PickColorRouteArgs>();
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.ColorPickerPage(
          key: args.key,
          pickedColor: args.pickedColor,
          controller: args.controller,
        ),
      );
    },
    DetailQuestionRoute.name: (routeData) {
      final args = routeData.argsAs<DetailQuestionRouteArgs>();
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.DetailQuestion(
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
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i18.ReviewSheet(
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
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i19.CreateReview(
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
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i20.EditSheet(
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
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i21.EditDemo(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    ActivityScreen.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i22.ActivityScreen(),
      );
    },
    AllAchievementRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i23.AllAchievement(),
      );
    },
    CreateSheetScreen.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i24.CreateSheetScreen(),
      );
    },
    CreateDetailSheetRoute.name: (routeData) {
      final args = routeData.argsAs<CreateDetailSheetRouteArgs>();
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i25.CreateDetailSheet(
          key: args.key,
          demoPages: args.demoPages,
        ),
      );
    },
    ViewImportSheetRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i26.ViewImportSheet(),
      );
    },
    PickDemoPagesRoute.name: (routeData) {
      final args = routeData.argsAs<PickDemoPagesRouteArgs>();
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i27.PickDemoPages(
          key: args.key,
          doc: args.doc,
          pagesNumber: args.pagesNumber,
        ),
      );
    },
    SheetListScreen.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i28.SheetListScreen(),
      );
    },
    SheetListDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SheetListDetailRouteArgs>(
          orElse: () => SheetListDetailRouteArgs(
              sheetId: pathParams.getString('sheetId')));
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i29.SheetListDetail(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    ProfileScreen.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i30.ProfileScreen(),
      );
    },
    EditProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditProfileRouteArgs>(
          orElse: () =>
              EditProfileRouteArgs(userId: pathParams.getString('userId')));
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i31.EditProfile(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    MyAccount.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i32.MyAccount(),
      );
    },
    ChangeEmailRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i33.ChangeEmail(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i34.ChangePassword(),
      );
    },
    AboutSubjectRoute.name: (routeData) {
      final args = routeData.argsAs<AboutSubjectRouteArgs>();
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i35.AboutSubject(
          key: args.key,
          grade: args.grade,
        ),
      );
    },
    AboutGradeRoute.name: (routeData) {
      return _i37.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i36.AboutGrade(),
      );
    },
  };

  @override
  List<_i37.RouteConfig> get routes => [
        _i37.RouteConfig(
          MainScreen.name,
          path: '/',
          children: [
            _i37.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainScreen.name,
              children: [
                _i37.RouteConfig(
                  HomeScreenRoute.name,
                  path: '',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  TestUIRoute.name,
                  path: 'test_ui',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  SearchingSheetRoute.name,
                  path: 'searching',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  RecommendSheetRoute.name,
                  path: 'recommend_sheet',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  TopSheetRoute.name,
                  path: 'top_sheet',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  OtherProfileRoute.name,
                  path: 'other_profile/:userId',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  DetailSheetRoute.name,
                  path: ':sheetId',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  ReadSheetRoute.name,
                  path: ':sheetId/read_sheet',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  AskQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  CreateQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question/create_question',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  PickColorRoute.name,
                  path:
                      ':sheetId/read_sheet/ask_question/create_question/pick_color',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  DetailQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question/:questionId',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  ReviewSheetRoute.name,
                  path: ':sheetId/review_sheet',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  CreateReviewRoute.name,
                  path: ':sheetId/create_review',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  EditSheetRoute.name,
                  path: ':sheetId/edit_sheet',
                  parent: HomeRoute.name,
                ),
                _i37.RouteConfig(
                  EditDemoRoute.name,
                  path: ':sheetId/edit_sheet/edit_demo',
                  parent: HomeRoute.name,
                ),
              ],
            ),
            _i37.RouteConfig(
              ActivityRoute.name,
              path: 'activity',
              parent: MainScreen.name,
              children: [
                _i37.RouteConfig(
                  ActivityScreen.name,
                  path: '',
                  parent: ActivityRoute.name,
                ),
                _i37.RouteConfig(
                  AllAchievementRoute.name,
                  path: 'all_achievement',
                  parent: ActivityRoute.name,
                ),
              ],
            ),
            _i37.RouteConfig(
              CreateSheetRoute.name,
              path: 'create_sheet',
              parent: MainScreen.name,
              children: [
                _i37.RouteConfig(
                  CreateSheetScreen.name,
                  path: '',
                  parent: CreateSheetRoute.name,
                ),
                _i37.RouteConfig(
                  CreateDetailSheetRoute.name,
                  path: 'create_detail_sheet',
                  parent: CreateSheetRoute.name,
                ),
                _i37.RouteConfig(
                  ViewImportSheetRoute.name,
                  path: 'view_import_sheet',
                  parent: CreateSheetRoute.name,
                ),
                _i37.RouteConfig(
                  PickDemoPagesRoute.name,
                  path: 'pick_demo_pages',
                  parent: CreateSheetRoute.name,
                ),
              ],
            ),
            _i37.RouteConfig(
              SheetListRoute.name,
              path: 'sheet_list',
              parent: MainScreen.name,
              children: [
                _i37.RouteConfig(
                  SheetListScreen.name,
                  path: '',
                  parent: SheetListRoute.name,
                ),
                _i37.RouteConfig(
                  SheetListDetailRoute.name,
                  path: ':sheetId',
                  parent: SheetListRoute.name,
                ),
              ],
            ),
            _i37.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: MainScreen.name,
              children: [
                _i37.RouteConfig(
                  ProfileScreen.name,
                  path: '',
                  parent: ProfileRoute.name,
                ),
                _i37.RouteConfig(
                  EditProfileRoute.name,
                  path: ':userId',
                  parent: ProfileRoute.name,
                ),
              ],
            ),
          ],
        ),
        _i37.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i37.RouteConfig(
          RegisterRoute.name,
          path: '/register',
        ),
        _i37.RouteConfig(
          MyAccountRoute.name,
          path: '/my_account',
          children: [
            _i37.RouteConfig(
              MyAccount.name,
              path: '',
              parent: MyAccountRoute.name,
            ),
            _i37.RouteConfig(
              ChangeEmailRoute.name,
              path: 'change_email',
              parent: MyAccountRoute.name,
            ),
            _i37.RouteConfig(
              ChangePasswordRoute.name,
              path: 'change_password',
              parent: MyAccountRoute.name,
            ),
          ],
        ),
        _i37.RouteConfig(
          TopUpRoute.name,
          path: '/top_up',
        ),
        _i37.RouteConfig(
          FirstLoginRoute.name,
          path: '/first_login',
          children: [
            _i37.RouteConfig(
              '#redirect',
              path: '',
              parent: FirstLoginRoute.name,
              redirectTo: 'about_grade',
              fullMatch: true,
            ),
            _i37.RouteConfig(
              AboutSubjectRoute.name,
              path: 'about_subject',
              parent: FirstLoginRoute.name,
            ),
            _i37.RouteConfig(
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
class MainScreen extends _i37.PageRouteInfo<void> {
  const MainScreen({List<_i37.PageRouteInfo>? children})
      : super(
          MainScreen.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i37.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterRoute extends _i37.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class MyAccountRoute extends _i37.PageRouteInfo<void> {
  const MyAccountRoute({List<_i37.PageRouteInfo>? children})
      : super(
          MyAccountRoute.name,
          path: '/my_account',
          initialChildren: children,
        );

  static const String name = 'MyAccountRoute';
}

/// generated route for
/// [_i5.TopUp]
class TopUpRoute extends _i37.PageRouteInfo<void> {
  const TopUpRoute()
      : super(
          TopUpRoute.name,
          path: '/top_up',
        );

  static const String name = 'TopUpRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class FirstLoginRoute extends _i37.PageRouteInfo<void> {
  const FirstLoginRoute({List<_i37.PageRouteInfo>? children})
      : super(
          FirstLoginRoute.name,
          path: '/first_login',
          initialChildren: children,
        );

  static const String name = 'FirstLoginRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class HomeRoute extends _i37.PageRouteInfo<void> {
  const HomeRoute({List<_i37.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ActivityRoute extends _i37.PageRouteInfo<void> {
  const ActivityRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ActivityRoute.name,
          path: 'activity',
          initialChildren: children,
        );

  static const String name = 'ActivityRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class CreateSheetRoute extends _i37.PageRouteInfo<void> {
  const CreateSheetRoute({List<_i37.PageRouteInfo>? children})
      : super(
          CreateSheetRoute.name,
          path: 'create_sheet',
          initialChildren: children,
        );

  static const String name = 'CreateSheetRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class SheetListRoute extends _i37.PageRouteInfo<void> {
  const SheetListRoute({List<_i37.PageRouteInfo>? children})
      : super(
          SheetListRoute.name,
          path: 'sheet_list',
          initialChildren: children,
        );

  static const String name = 'SheetListRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ProfileRoute extends _i37.PageRouteInfo<void> {
  const ProfileRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i6.HomeScreen]
class HomeScreenRoute extends _i37.PageRouteInfo<void> {
  const HomeScreenRoute()
      : super(
          HomeScreenRoute.name,
          path: '',
        );

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i7.TestUIPage]
class TestUIRoute extends _i37.PageRouteInfo<void> {
  const TestUIRoute()
      : super(
          TestUIRoute.name,
          path: 'test_ui',
        );

  static const String name = 'TestUIRoute';
}

/// generated route for
/// [_i8.SearchingSheet]
class SearchingSheetRoute extends _i37.PageRouteInfo<void> {
  const SearchingSheetRoute()
      : super(
          SearchingSheetRoute.name,
          path: 'searching',
        );

  static const String name = 'SearchingSheetRoute';
}

/// generated route for
/// [_i9.RecommendSheet]
class RecommendSheetRoute extends _i37.PageRouteInfo<void> {
  const RecommendSheetRoute()
      : super(
          RecommendSheetRoute.name,
          path: 'recommend_sheet',
        );

  static const String name = 'RecommendSheetRoute';
}

/// generated route for
/// [_i10.TopSheet]
class TopSheetRoute extends _i37.PageRouteInfo<void> {
  const TopSheetRoute()
      : super(
          TopSheetRoute.name,
          path: 'top_sheet',
        );

  static const String name = 'TopSheetRoute';
}

/// generated route for
/// [_i11.OtherProfile]
class OtherProfileRoute extends _i37.PageRouteInfo<OtherProfileRouteArgs> {
  OtherProfileRoute({
    _i38.Key? key,
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

  final _i38.Key? key;

  final String userId;

  @override
  String toString() {
    return 'OtherProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i12.DetailSheet]
class DetailSheetRoute extends _i37.PageRouteInfo<DetailSheetRouteArgs> {
  DetailSheetRoute({
    _i38.Key? key,
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

  final _i38.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'DetailSheetRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i13.ReadSheet]
class ReadSheetRoute extends _i37.PageRouteInfo<ReadSheetRouteArgs> {
  ReadSheetRoute({
    _i38.Key? key,
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

  final _i38.Key? key;

  final String sheetId;

  final String sheetTitle;

  @override
  String toString() {
    return 'ReadSheetRouteArgs{key: $key, sheetId: $sheetId, sheetTitle: $sheetTitle}';
  }
}

/// generated route for
/// [_i14.AskQuestion]
class AskQuestionRoute extends _i37.PageRouteInfo<AskQuestionRouteArgs> {
  AskQuestionRoute({
    _i38.Key? key,
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

  final _i38.Key? key;

  final String sheetId;

  final int askingPage;

  @override
  String toString() {
    return 'AskQuestionRouteArgs{key: $key, sheetId: $sheetId, askingPage: $askingPage}';
  }
}

/// generated route for
/// [_i15.CreateQuestion]
class CreateQuestionRoute extends _i37.PageRouteInfo<CreateQuestionRouteArgs> {
  CreateQuestionRoute({
    _i38.Key? key,
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

  final _i38.Key? key;

  final String sheetId;

  final int askingPage;

  @override
  String toString() {
    return 'CreateQuestionRouteArgs{key: $key, sheetId: $sheetId, askingPage: $askingPage}';
  }
}

/// generated route for
/// [_i16.ColorPickerPage]
class PickColorRoute extends _i37.PageRouteInfo<PickColorRouteArgs> {
  PickColorRoute({
    _i38.Key? key,
    required _i39.Color pickedColor,
    required _i40.PainterController controller,
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

  final _i38.Key? key;

  final _i39.Color pickedColor;

  final _i40.PainterController controller;

  @override
  String toString() {
    return 'PickColorRouteArgs{key: $key, pickedColor: $pickedColor, controller: $controller}';
  }
}

/// generated route for
/// [_i17.DetailQuestion]
class DetailQuestionRoute extends _i37.PageRouteInfo<DetailQuestionRouteArgs> {
  DetailQuestionRoute({
    _i38.Key? key,
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

  final _i38.Key? key;

  final String sheetId;

  final String questionId;

  final int askingPage;

  @override
  String toString() {
    return 'DetailQuestionRouteArgs{key: $key, sheetId: $sheetId, questionId: $questionId, askingPage: $askingPage}';
  }
}

/// generated route for
/// [_i18.ReviewSheet]
class ReviewSheetRoute extends _i37.PageRouteInfo<ReviewSheetRouteArgs> {
  ReviewSheetRoute({
    _i38.Key? key,
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

  final _i38.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'ReviewSheetRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i19.CreateReview]
class CreateReviewRoute extends _i37.PageRouteInfo<CreateReviewRouteArgs> {
  CreateReviewRoute({
    _i38.Key? key,
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

  final _i38.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'CreateReviewRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i20.EditSheet]
class EditSheetRoute extends _i37.PageRouteInfo<EditSheetRouteArgs> {
  EditSheetRoute({
    _i38.Key? key,
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

  final _i38.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'EditSheetRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i21.EditDemo]
class EditDemoRoute extends _i37.PageRouteInfo<EditDemoRouteArgs> {
  EditDemoRoute({
    _i38.Key? key,
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

  final _i38.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'EditDemoRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i22.ActivityScreen]
class ActivityScreen extends _i37.PageRouteInfo<void> {
  const ActivityScreen()
      : super(
          ActivityScreen.name,
          path: '',
        );

  static const String name = 'ActivityScreen';
}

/// generated route for
/// [_i23.AllAchievement]
class AllAchievementRoute extends _i37.PageRouteInfo<void> {
  const AllAchievementRoute()
      : super(
          AllAchievementRoute.name,
          path: 'all_achievement',
        );

  static const String name = 'AllAchievementRoute';
}

/// generated route for
/// [_i24.CreateSheetScreen]
class CreateSheetScreen extends _i37.PageRouteInfo<void> {
  const CreateSheetScreen()
      : super(
          CreateSheetScreen.name,
          path: '',
        );

  static const String name = 'CreateSheetScreen';
}

/// generated route for
/// [_i25.CreateDetailSheet]
class CreateDetailSheetRoute
    extends _i37.PageRouteInfo<CreateDetailSheetRouteArgs> {
  CreateDetailSheetRoute({
    _i38.Key? key,
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

  final _i38.Key? key;

  final List<int> demoPages;

  @override
  String toString() {
    return 'CreateDetailSheetRouteArgs{key: $key, demoPages: $demoPages}';
  }
}

/// generated route for
/// [_i26.ViewImportSheet]
class ViewImportSheetRoute extends _i37.PageRouteInfo<void> {
  const ViewImportSheetRoute()
      : super(
          ViewImportSheetRoute.name,
          path: 'view_import_sheet',
        );

  static const String name = 'ViewImportSheetRoute';
}

/// generated route for
/// [_i27.PickDemoPages]
class PickDemoPagesRoute extends _i37.PageRouteInfo<PickDemoPagesRouteArgs> {
  PickDemoPagesRoute({
    _i38.Key? key,
    required _i41.PdfDocument doc,
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

  final _i38.Key? key;

  final _i41.PdfDocument doc;

  final int pagesNumber;

  @override
  String toString() {
    return 'PickDemoPagesRouteArgs{key: $key, doc: $doc, pagesNumber: $pagesNumber}';
  }
}

/// generated route for
/// [_i28.SheetListScreen]
class SheetListScreen extends _i37.PageRouteInfo<void> {
  const SheetListScreen()
      : super(
          SheetListScreen.name,
          path: '',
        );

  static const String name = 'SheetListScreen';
}

/// generated route for
/// [_i29.SheetListDetail]
class SheetListDetailRoute
    extends _i37.PageRouteInfo<SheetListDetailRouteArgs> {
  SheetListDetailRoute({
    _i38.Key? key,
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

  final _i38.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'SheetListDetailRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i30.ProfileScreen]
class ProfileScreen extends _i37.PageRouteInfo<void> {
  const ProfileScreen()
      : super(
          ProfileScreen.name,
          path: '',
        );

  static const String name = 'ProfileScreen';
}

/// generated route for
/// [_i31.EditProfile]
class EditProfileRoute extends _i37.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i38.Key? key,
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

  final _i38.Key? key;

  final String userId;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i32.MyAccount]
class MyAccount extends _i37.PageRouteInfo<void> {
  const MyAccount()
      : super(
          MyAccount.name,
          path: '',
        );

  static const String name = 'MyAccount';
}

/// generated route for
/// [_i33.ChangeEmail]
class ChangeEmailRoute extends _i37.PageRouteInfo<void> {
  const ChangeEmailRoute()
      : super(
          ChangeEmailRoute.name,
          path: 'change_email',
        );

  static const String name = 'ChangeEmailRoute';
}

/// generated route for
/// [_i34.ChangePassword]
class ChangePasswordRoute extends _i37.PageRouteInfo<void> {
  const ChangePasswordRoute()
      : super(
          ChangePasswordRoute.name,
          path: 'change_password',
        );

  static const String name = 'ChangePasswordRoute';
}

/// generated route for
/// [_i35.AboutSubject]
class AboutSubjectRoute extends _i37.PageRouteInfo<AboutSubjectRouteArgs> {
  AboutSubjectRoute({
    _i38.Key? key,
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

  final _i38.Key? key;

  final String grade;

  @override
  String toString() {
    return 'AboutSubjectRouteArgs{key: $key, grade: $grade}';
  }
}

/// generated route for
/// [_i36.AboutGrade]
class AboutGradeRoute extends _i37.PageRouteInfo<void> {
  const AboutGradeRoute()
      : super(
          AboutGradeRoute.name,
          path: 'about_grade',
        );

  static const String name = 'AboutGradeRoute';
}
