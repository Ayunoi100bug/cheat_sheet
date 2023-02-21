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
import 'dart:io' as _i34;

import 'package:auto_route/auto_route.dart' as _i32;
import 'package:auto_route/empty_router_widgets.dart' as _i5;
import 'package:flutter/material.dart' as _i33;

import '../../view/activity_screen/activity_screen.dart' as _i17;
import '../../view/create_sheet_screen/create_detail_sheet.dart' as _i19;
import '../../view/create_sheet_screen/import_sheet_screen.dart' as _i18;
import '../../view/create_sheet_screen/pick_demo_pages.dart' as _i21;
import '../../view/create_sheet_screen/view_import_sheet.dart' as _i20;
import '../../view/home_screen/create_review.dart' as _i16;
import '../../view/home_screen/detail_sheet.dart' as _i10;
import '../../view/home_screen/home_screen.dart' as _i7;
import '../../view/home_screen/question/ask_question.dart' as _i12;
import '../../view/home_screen/question/create_question.dart' as _i13;
import '../../view/home_screen/question/detail_question.dart' as _i14;
import '../../view/home_screen/read_sheet.dart' as _i11;
import '../../view/home_screen/review_sheet.dart' as _i15;
import '../../view/home_screen/searching_sheet.dart' as _i9;
import '../../view/login.dart' as _i2;
import '../../view/main_screen.dart' as _i1;
import '../../view/profile_screen/edit_profile.dart' as _i25;
import '../../view/profile_screen/profile_screen.dart' as _i24;
import '../../view/register.dart' as _i3;
import '../../view/sheet_list_screen/sheet_list_detail.dart' as _i23;
import '../../view/sheet_list_screen/sheet_list_screen.dart' as _i22;
import '../../view/side_bar_menu/bank_account/add_card.dart' as _i31;
import '../../view/side_bar_menu/bank_account/add_payment_methods.dart' as _i30;
import '../../view/side_bar_menu/bank_account/bank_account.dart' as _i29;
import '../../view/side_bar_menu/my_account/change_email.dart' as _i27;
import '../../view/side_bar_menu/my_account/change_password.dart' as _i28;
import '../../view/side_bar_menu/my_account/my_account.dart' as _i26;
import '../../view/side_bar_menu/notification_setting.dart' as _i4;
import '../../view/side_bar_menu/top_up.dart' as _i6;
import '../../view/test_ui_book.dart' as _i8;

class AppRouter extends _i32.RootStackRouter {
  AppRouter([_i33.GlobalKey<_i33.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i32.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MainScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterScreen(),
      );
    },
    NotificationSettingRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.NotificationSetting(),
      );
    },
    MyAccountRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    TopUpRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.TopUp(),
      );
    },
    BankAccountRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    ActivityRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    CreateSheetRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    SheetListRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    HomeScreen.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.HomeScreen(),
      );
    },
    TestUIRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.TestUIPage(),
      );
    },
    SearchingSheetRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.SearchingSheet(),
      );
    },
    DetailSheetRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DetailSheetRouteArgs>(
          orElse: () =>
              DetailSheetRouteArgs(sheetId: pathParams.getString('sheetId')));
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.DetailSheet(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    ReadSheetRoute.name: (routeData) {
      final args = routeData.argsAs<ReadSheetRouteArgs>();
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.ReadSheet(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    AskQuestionRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AskQuestionRouteArgs>(
          orElse: () =>
              AskQuestionRouteArgs(sheetId: pathParams.getString('sheetId')));
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.AskQuestion(
          key: args.key,
          sheetId: args.sheetId,
          askingPage: args.askingPage,
        ),
      );
    },
    CreateQuestionRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.CreateQuestion(
          key: args.key,
          sheetId: args.sheetId,
          askingPage: args.askingPage,
        ),
      );
    },
    DetailQuestionRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DetailQuestionRouteArgs>(
          orElse: () => DetailQuestionRouteArgs(
                sheetId: pathParams.getString('sheetId'),
                questionId: pathParams.getString('questionId'),
              ));
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.DetailQuestion(
          key: args.key,
          sheetId: args.sheetId,
          questionId: args.questionId,
        ),
      );
    },
    ReviewSheetRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ReviewSheetRouteArgs>(
          orElse: () =>
              ReviewSheetRouteArgs(sheetId: pathParams.getString('sheetId')));
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.ReviewSheet(
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
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.CreateReview(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    ActivityScreen.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i17.ActivityScreen(),
      );
    },
    CreateSheetScreen.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i18.CreateSheetScreen(),
      );
    },
    CreateDetailSheetRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i19.CreateDetailSheet(),
      );
    },
    ViewImportSheetRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i20.ViewImportSheet(),
      );
    },
    PickDemoPagesRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i21.PickDemoPages(),
      );
    },
    SheetListScreen.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i22.SheetListScreen(),
      );
    },
    SheetListDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SheetListDetailRouteArgs>(
          orElse: () => SheetListDetailRouteArgs(
              sheetId: pathParams.getString('sheetId')));
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i23.SheetListDetail(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    ProfileScreen.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i24.ProfileScreen(),
      );
    },
    EditProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditProfileRouteArgs>(
          orElse: () =>
              EditProfileRouteArgs(userId: pathParams.getString('userId')));
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i25.EditProfile(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    MyAccount.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i26.MyAccount(),
      );
    },
    ChangeEmailRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i27.ChangeEmail(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i28.ChangePassword(),
      );
    },
    BankAccount.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i29.BankAccount(),
      );
    },
    AddPaymentMethodsRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i30.AddPaymentMethods(),
      );
    },
    AddCardRoute.name: (routeData) {
      return _i32.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i31.AddCard(),
      );
    },
  };

  @override
  List<_i32.RouteConfig> get routes => [
        _i32.RouteConfig(
          MainScreen.name,
          path: '/',
          children: [
            _i32.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainScreen.name,
              children: [
                _i32.RouteConfig(
                  HomeScreen.name,
                  path: '',
                  parent: HomeRoute.name,
                ),
                _i32.RouteConfig(
                  TestUIRoute.name,
                  path: 'test_ui',
                  parent: HomeRoute.name,
                ),
                _i32.RouteConfig(
                  SearchingSheetRoute.name,
                  path: 'searching',
                  parent: HomeRoute.name,
                ),
                _i32.RouteConfig(
                  DetailSheetRoute.name,
                  path: ':sheetId',
                  parent: HomeRoute.name,
                ),
                _i32.RouteConfig(
                  ReadSheetRoute.name,
                  path: ':sheetId/read_sheet',
                  parent: HomeRoute.name,
                ),
                _i32.RouteConfig(
                  AskQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question',
                  parent: HomeRoute.name,
                ),
                _i32.RouteConfig(
                  CreateQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question/create_question',
                  parent: HomeRoute.name,
                ),
                _i32.RouteConfig(
                  DetailQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question/:questionId',
                  parent: HomeRoute.name,
                ),
                _i32.RouteConfig(
                  ReviewSheetRoute.name,
                  path: ':sheetId/review_sheet',
                  parent: HomeRoute.name,
                ),
                _i32.RouteConfig(
                  CreateReviewRoute.name,
                  path: ':sheetId/create_review',
                  parent: HomeRoute.name,
                ),
              ],
            ),
            _i32.RouteConfig(
              ActivityRoute.name,
              path: 'activity',
              parent: MainScreen.name,
              children: [
                _i32.RouteConfig(
                  ActivityScreen.name,
                  path: '',
                  parent: ActivityRoute.name,
                )
              ],
            ),
            _i32.RouteConfig(
              CreateSheetRoute.name,
              path: 'create_sheet',
              parent: MainScreen.name,
              children: [
                _i32.RouteConfig(
                  CreateSheetScreen.name,
                  path: '',
                  parent: CreateSheetRoute.name,
                ),
                _i32.RouteConfig(
                  CreateDetailSheetRoute.name,
                  path: 'create_detail_sheet',
                  parent: CreateSheetRoute.name,
                ),
                _i32.RouteConfig(
                  ViewImportSheetRoute.name,
                  path: 'view_import_sheet',
                  parent: CreateSheetRoute.name,
                ),
                _i32.RouteConfig(
                  PickDemoPagesRoute.name,
                  path: 'pick_demo_pages',
                  parent: CreateSheetRoute.name,
                ),
              ],
            ),
            _i32.RouteConfig(
              SheetListRoute.name,
              path: 'sheet_list',
              parent: MainScreen.name,
              children: [
                _i32.RouteConfig(
                  SheetListScreen.name,
                  path: '',
                  parent: SheetListRoute.name,
                ),
                _i32.RouteConfig(
                  SheetListDetailRoute.name,
                  path: ':sheetId',
                  parent: SheetListRoute.name,
                ),
              ],
            ),
            _i32.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: MainScreen.name,
              children: [
                _i32.RouteConfig(
                  ProfileScreen.name,
                  path: '',
                  parent: ProfileRoute.name,
                ),
                _i32.RouteConfig(
                  EditProfileRoute.name,
                  path: ':userId',
                  parent: ProfileRoute.name,
                ),
              ],
            ),
          ],
        ),
        _i32.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i32.RouteConfig(
          RegisterRoute.name,
          path: '/register',
        ),
        _i32.RouteConfig(
          NotificationSettingRoute.name,
          path: '/notification_setting',
        ),
        _i32.RouteConfig(
          MyAccountRoute.name,
          path: '/my_account',
          children: [
            _i32.RouteConfig(
              MyAccount.name,
              path: '',
              parent: MyAccountRoute.name,
            ),
            _i32.RouteConfig(
              ChangeEmailRoute.name,
              path: 'change_email',
              parent: MyAccountRoute.name,
            ),
            _i32.RouteConfig(
              ChangePasswordRoute.name,
              path: 'change_password',
              parent: MyAccountRoute.name,
            ),
          ],
        ),
        _i32.RouteConfig(
          TopUpRoute.name,
          path: '/top_up',
        ),
        _i32.RouteConfig(
          BankAccountRoute.name,
          path: '/bank_account',
          children: [
            _i32.RouteConfig(
              BankAccount.name,
              path: '',
              parent: BankAccountRoute.name,
            ),
            _i32.RouteConfig(
              AddPaymentMethodsRoute.name,
              path: 'add_payment_methods',
              parent: BankAccountRoute.name,
            ),
            _i32.RouteConfig(
              AddCardRoute.name,
              path: 'add_payment_methods/add_card',
              parent: BankAccountRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreen extends _i32.PageRouteInfo<void> {
  const MainScreen({List<_i32.PageRouteInfo>? children})
      : super(
          MainScreen.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i32.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterRoute extends _i32.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i4.NotificationSetting]
class NotificationSettingRoute extends _i32.PageRouteInfo<void> {
  const NotificationSettingRoute()
      : super(
          NotificationSettingRoute.name,
          path: '/notification_setting',
        );

  static const String name = 'NotificationSettingRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class MyAccountRoute extends _i32.PageRouteInfo<void> {
  const MyAccountRoute({List<_i32.PageRouteInfo>? children})
      : super(
          MyAccountRoute.name,
          path: '/my_account',
          initialChildren: children,
        );

  static const String name = 'MyAccountRoute';
}

/// generated route for
/// [_i6.TopUp]
class TopUpRoute extends _i32.PageRouteInfo<void> {
  const TopUpRoute()
      : super(
          TopUpRoute.name,
          path: '/top_up',
        );

  static const String name = 'TopUpRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class BankAccountRoute extends _i32.PageRouteInfo<void> {
  const BankAccountRoute({List<_i32.PageRouteInfo>? children})
      : super(
          BankAccountRoute.name,
          path: '/bank_account',
          initialChildren: children,
        );

  static const String name = 'BankAccountRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class HomeRoute extends _i32.PageRouteInfo<void> {
  const HomeRoute({List<_i32.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class ActivityRoute extends _i32.PageRouteInfo<void> {
  const ActivityRoute({List<_i32.PageRouteInfo>? children})
      : super(
          ActivityRoute.name,
          path: 'activity',
          initialChildren: children,
        );

  static const String name = 'ActivityRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class CreateSheetRoute extends _i32.PageRouteInfo<void> {
  const CreateSheetRoute({List<_i32.PageRouteInfo>? children})
      : super(
          CreateSheetRoute.name,
          path: 'create_sheet',
          initialChildren: children,
        );

  static const String name = 'CreateSheetRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class SheetListRoute extends _i32.PageRouteInfo<void> {
  const SheetListRoute({List<_i32.PageRouteInfo>? children})
      : super(
          SheetListRoute.name,
          path: 'sheet_list',
          initialChildren: children,
        );

  static const String name = 'SheetListRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class ProfileRoute extends _i32.PageRouteInfo<void> {
  const ProfileRoute({List<_i32.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i7.HomeScreen]
class HomeScreen extends _i32.PageRouteInfo<void> {
  const HomeScreen()
      : super(
          HomeScreen.name,
          path: '',
        );

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i8.TestUIPage]
class TestUIRoute extends _i32.PageRouteInfo<void> {
  const TestUIRoute()
      : super(
          TestUIRoute.name,
          path: 'test_ui',
        );

  static const String name = 'TestUIRoute';
}

/// generated route for
/// [_i9.SearchingSheet]
class SearchingSheetRoute extends _i32.PageRouteInfo<void> {
  const SearchingSheetRoute()
      : super(
          SearchingSheetRoute.name,
          path: 'searching',
        );

  static const String name = 'SearchingSheetRoute';
}

/// generated route for
/// [_i10.DetailSheet]
class DetailSheetRoute extends _i32.PageRouteInfo<DetailSheetRouteArgs> {
  DetailSheetRoute({
    _i33.Key? key,
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

  final _i33.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'DetailSheetRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i11.ReadSheet]
class ReadSheetRoute extends _i32.PageRouteInfo<ReadSheetRouteArgs> {
  ReadSheetRoute({
    _i33.Key? key,
    required String sheetId,
    required _i34.File file,
  }) : super(
          ReadSheetRoute.name,
          path: ':sheetId/read_sheet',
          args: ReadSheetRouteArgs(
            key: key,
            sheetId: sheetId,
          ),
          rawPathParams: {'sheetId': sheetId},
        );

  static const String name = 'ReadSheetRoute';
}

class ReadSheetRouteArgs {
  const ReadSheetRouteArgs({
    this.key,
    required this.sheetId,
  });

  final _i33.Key? key;

  final String sheetId;

  final _i34.File file;

  @override
  String toString() {
    return 'ReadSheetRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i12.AskQuestion]
class AskQuestionRoute extends _i32.PageRouteInfo<AskQuestionRouteArgs> {
  AskQuestionRoute({
    _i33.Key? key,
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

  final _i33.Key? key;

  final String sheetId;

  final int askingPage;

  @override
  String toString() {
    return 'AskQuestionRouteArgs{key: $key, sheetId: $sheetId, askingPage: $askingPage}';
  }
}

/// generated route for
/// [_i13.CreateQuestion]
class CreateQuestionRoute extends _i32.PageRouteInfo<void> {
  const CreateQuestionRoute()
      : super(
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

  final _i32.Key? key;

  final String sheetId;

  final int askingPage;

  @override
  String toString() {
    return 'CreateQuestionRouteArgs{key: $key, sheetId: $sheetId, askingPage: $askingPage}';
  }
}

/// generated route for
/// [_i14.DetailQuestion]
class DetailQuestionRoute extends _i32.PageRouteInfo<DetailQuestionRouteArgs> {
  DetailQuestionRoute({
    _i33.Key? key,
    required String sheetId,
    required String questionId,
  }) : super(
          DetailQuestionRoute.name,
          path: ':sheetId/read_sheet/ask_question/:questionId',
          args: DetailQuestionRouteArgs(
            key: key,
            sheetId: sheetId,
            questionId: questionId,
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
  });

  final _i33.Key? key;

  final String sheetId;

  final String questionId;

  @override
  String toString() {
    return 'DetailQuestionRouteArgs{key: $key, sheetId: $sheetId, questionId: $questionId}';
  }
}

/// generated route for
/// [_i15.ReviewSheet]
class ReviewSheetRoute extends _i32.PageRouteInfo<ReviewSheetRouteArgs> {
  ReviewSheetRoute({
    _i33.Key? key,
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

  final _i33.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'ReviewSheetRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i16.CreateReview]
class CreateReviewRoute extends _i32.PageRouteInfo<CreateReviewRouteArgs> {
  CreateReviewRoute({
    _i33.Key? key,
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

  final _i33.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'CreateReviewRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i17.ActivityScreen]
class ActivityScreen extends _i32.PageRouteInfo<void> {
  const ActivityScreen()
      : super(
          ActivityScreen.name,
          path: '',
        );

  static const String name = 'ActivityScreen';
}

/// generated route for
/// [_i18.CreateSheetScreen]
class CreateSheetScreen extends _i32.PageRouteInfo<void> {
  const CreateSheetScreen()
      : super(
          CreateSheetScreen.name,
          path: '',
        );

  static const String name = 'CreateSheetScreen';
}

/// generated route for
/// [_i19.CreateDetailSheet]
class CreateDetailSheetRoute extends _i32.PageRouteInfo<void> {
  const CreateDetailSheetRoute()
      : super(
          CreateDetailSheetRoute.name,
          path: 'create_detail_sheet',
        );

  static const String name = 'CreateDetailSheetRoute';
}

/// generated route for
/// [_i20.ViewImportSheet]
class ViewImportSheetRoute extends _i32.PageRouteInfo<void> {
  const ViewImportSheetRoute()
      : super(
          ViewImportSheetRoute.name,
          path: 'view_import_sheet',
        );

  static const String name = 'ViewImportSheetRoute';
}

/// generated route for
/// [_i21.PickDemoPages]
class PickDemoPagesRoute extends _i32.PageRouteInfo<void> {
  const PickDemoPagesRoute()
      : super(
          PickDemoPagesRoute.name,
          path: 'pick_demo_pages',
        );

  static const String name = 'PickDemoPagesRoute';
}

/// generated route for
/// [_i22.SheetListScreen]
class SheetListScreen extends _i32.PageRouteInfo<void> {
  const SheetListScreen()
      : super(
          SheetListScreen.name,
          path: '',
        );

  static const String name = 'SheetListScreen';
}

/// generated route for
/// [_i23.SheetListDetail]
class SheetListDetailRoute
    extends _i32.PageRouteInfo<SheetListDetailRouteArgs> {
  SheetListDetailRoute({
    _i33.Key? key,
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

  final _i33.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'SheetListDetailRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i24.ProfileScreen]
class ProfileScreen extends _i32.PageRouteInfo<void> {
  const ProfileScreen()
      : super(
          ProfileScreen.name,
          path: '',
        );

  static const String name = 'ProfileScreen';
}

/// generated route for
/// [_i25.EditProfile]
class EditProfileRoute extends _i32.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i33.Key? key,
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

  final _i33.Key? key;

  final String userId;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i26.MyAccount]
class MyAccount extends _i32.PageRouteInfo<void> {
  const MyAccount()
      : super(
          MyAccount.name,
          path: '',
        );

  static const String name = 'MyAccount';
}

/// generated route for
/// [_i27.ChangeEmail]
class ChangeEmailRoute extends _i32.PageRouteInfo<void> {
  const ChangeEmailRoute()
      : super(
          ChangeEmailRoute.name,
          path: 'change_email',
        );

  static const String name = 'ChangeEmailRoute';
}

/// generated route for
/// [_i28.ChangePassword]
class ChangePasswordRoute extends _i32.PageRouteInfo<void> {
  const ChangePasswordRoute()
      : super(
          ChangePasswordRoute.name,
          path: 'change_password',
        );

  static const String name = 'ChangePasswordRoute';
}

/// generated route for
/// [_i29.BankAccount]
class BankAccount extends _i32.PageRouteInfo<void> {
  const BankAccount()
      : super(
          BankAccount.name,
          path: '',
        );

  static const String name = 'BankAccount';
}

/// generated route for
/// [_i30.AddPaymentMethods]
class AddPaymentMethodsRoute extends _i32.PageRouteInfo<void> {
  const AddPaymentMethodsRoute()
      : super(
          AddPaymentMethodsRoute.name,
          path: 'add_payment_methods',
        );

  static const String name = 'AddPaymentMethodsRoute';
}

/// generated route for
/// [_i31.AddCard]
class AddCardRoute extends _i32.PageRouteInfo<void> {
  const AddCardRoute()
      : super(
          AddCardRoute.name,
          path: 'add_payment_methods/add_card',
        );

  static const String name = 'AddCardRoute';
}
