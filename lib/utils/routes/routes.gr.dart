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
import 'dart:io' as _i27;

import 'package:auto_route/auto_route.dart' as _i25;
import 'package:auto_route/empty_router_widgets.dart' as _i5;
import 'package:flutter/material.dart' as _i26;

import '../../view/activity_screen/activity_screen.dart' as _i15;
import '../../view/create_sheet_screen/create_detail_sheet.dart' as _i17;
import '../../view/create_sheet_screen/import_sheet_screen.dart' as _i16;
import '../../view/create_sheet_screen/view_import_sheet.dart' as _i18;
import '../../view/home_screen/ask_question.dart' as _i10;
import '../../view/home_screen/create_question.dart' as _i11;
import '../../view/home_screen/create_review.dart' as _i14;
import '../../view/home_screen/detail_question.dart' as _i12;
import '../../view/home_screen/detail_sheet.dart' as _i8;
import '../../view/home_screen/home_screen.dart' as _i6;
import '../../view/home_screen/read_sheet.dart' as _i9;
import '../../view/home_screen/review_sheet.dart' as _i13;
import '../../view/login.dart' as _i2;
import '../../view/main_screen.dart' as _i1;
import '../../view/profile_screen/edit_profile.dart' as _i21;
import '../../view/profile_screen/profile_screen.dart' as _i20;
import '../../view/register.dart' as _i3;
import '../../view/sheet_list_screen/sheet_list_screen.dart' as _i19;
import '../../view/side_bar_menu/bank_account/add_card.dart' as _i24;
import '../../view/side_bar_menu/bank_account/add_payment_methods.dart' as _i23;
import '../../view/side_bar_menu/bank_account/bank_account.dart' as _i22;
import '../../view/side_bar_menu/top_up.dart' as _i4;
import '../../view/test_ui_book.dart' as _i7;

class AppRouter extends _i25.RootStackRouter {
  AppRouter([_i26.GlobalKey<_i26.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i25.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MainScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterScreen(),
      );
    },
    TopUpRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.TopUp(),
      );
    },
    BankAccountRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    ActivityRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    CreateSheetRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    SheetListRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    HomeScreen.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.HomeScreen(),
      );
    },
    TestUIRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.TestUIPage(),
      );
    },
    DetailSheetRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DetailSheetRouteArgs>(
          orElse: () =>
              DetailSheetRouteArgs(sheetId: pathParams.getString('sheetId')));
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.DetailSheet(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    ReadSheetRoute.name: (routeData) {
      final args = routeData.argsAs<ReadSheetRouteArgs>();
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.ReadSheet(
          key: args.key,
          sheetId: args.sheetId,
          file: args.file,
        ),
      );
    },
    AskQuestionRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AskQuestionRouteArgs>(
          orElse: () =>
              AskQuestionRouteArgs(sheetId: pathParams.getString('sheetId')));
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.AskQuestion(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    CreateQuestionRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.CreateQuestion(),
      );
    },
    DetailQuestionRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DetailQuestionRouteArgs>(
          orElse: () => DetailQuestionRouteArgs(
                sheetId: pathParams.getString('sheetId'),
                questionId: pathParams.getString('questionId'),
              ));
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.DetailQuestion(
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
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.ReviewSheet(
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
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.CreateReview(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    ActivityScreen.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.ActivityScreen(),
      );
    },
    CreateSheetScreen.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.CreateSheetScreen(),
      );
    },
    CreateDetailSheetRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i17.CreateDetailSheet(),
      );
    },
    ViewImportSheetRoute.name: (routeData) {
      final args = routeData.argsAs<ViewImportSheetRouteArgs>();
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i18.ViewImportSheet(
          key: args.key,
          file: args.file,
        ),
      );
    },
    SheetListScreen.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i19.SheetListScreen(),
      );
    },
    ProfileScreen.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i20.ProfileScreen(),
      );
    },
    EditProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditProfileRouteArgs>(
          orElse: () =>
              EditProfileRouteArgs(userId: pathParams.getString('userId')));
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i21.EditProfile(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    BankAccount.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i22.BankAccount(),
      );
    },
    AddPaymentMethodsRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i23.AddPaymentMethods(),
      );
    },
    AddCardRoute.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i24.AddCard(),
      );
    },
  };

  @override
  List<_i25.RouteConfig> get routes => [
        _i25.RouteConfig(
          MainScreen.name,
          path: '/',
          children: [
            _i25.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainScreen.name,
              children: [
                _i25.RouteConfig(
                  HomeScreen.name,
                  path: '',
                  parent: HomeRoute.name,
                ),
                _i25.RouteConfig(
                  TestUIRoute.name,
                  path: 'test_ui',
                  parent: HomeRoute.name,
                ),
                _i25.RouteConfig(
                  DetailSheetRoute.name,
                  path: ':sheetId',
                  parent: HomeRoute.name,
                ),
                _i25.RouteConfig(
                  ReadSheetRoute.name,
                  path: ':sheetId/read_sheet',
                  parent: HomeRoute.name,
                ),
                _i25.RouteConfig(
                  AskQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question',
                  parent: HomeRoute.name,
                ),
                _i25.RouteConfig(
                  CreateQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question/create_question',
                  parent: HomeRoute.name,
                ),
                _i25.RouteConfig(
                  DetailQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question/:questionId',
                  parent: HomeRoute.name,
                ),
                _i25.RouteConfig(
                  ReviewSheetRoute.name,
                  path: ':sheetId/review_sheet',
                  parent: HomeRoute.name,
                ),
                _i25.RouteConfig(
                  CreateReviewRoute.name,
                  path: ':sheetId/create_review',
                  parent: HomeRoute.name,
                ),
              ],
            ),
            _i25.RouteConfig(
              ActivityRoute.name,
              path: 'activity',
              parent: MainScreen.name,
              children: [
                _i25.RouteConfig(
                  ActivityScreen.name,
                  path: '',
                  parent: ActivityRoute.name,
                )
              ],
            ),
            _i25.RouteConfig(
              CreateSheetRoute.name,
              path: 'create_sheet',
              parent: MainScreen.name,
              children: [
                _i25.RouteConfig(
                  CreateSheetScreen.name,
                  path: '',
                  parent: CreateSheetRoute.name,
                ),
                _i25.RouteConfig(
                  CreateDetailSheetRoute.name,
                  path: 'create_detail_sheet',
                  parent: CreateSheetRoute.name,
                ),
                _i25.RouteConfig(
                  ViewImportSheetRoute.name,
                  path: 'view_import_sheet',
                  parent: CreateSheetRoute.name,
                ),
              ],
            ),
            _i25.RouteConfig(
              SheetListRoute.name,
              path: 'sheet_list',
              parent: MainScreen.name,
              children: [
                _i25.RouteConfig(
                  SheetListScreen.name,
                  path: '',
                  parent: SheetListRoute.name,
                )
              ],
            ),
            _i25.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: MainScreen.name,
              children: [
                _i25.RouteConfig(
                  ProfileScreen.name,
                  path: '',
                  parent: ProfileRoute.name,
                ),
                _i25.RouteConfig(
                  EditProfileRoute.name,
                  path: ':userId',
                  parent: ProfileRoute.name,
                ),
              ],
            ),
          ],
        ),
        _i25.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i25.RouteConfig(
          RegisterRoute.name,
          path: '/register',
        ),
        _i25.RouteConfig(
          TopUpRoute.name,
          path: '/top_up',
        ),
        _i25.RouteConfig(
          BankAccountRoute.name,
          path: '/bank_account',
          children: [
            _i25.RouteConfig(
              BankAccount.name,
              path: '',
              parent: BankAccountRoute.name,
            ),
            _i25.RouteConfig(
              AddPaymentMethodsRoute.name,
              path: 'add_payment_methods',
              parent: BankAccountRoute.name,
            ),
            _i25.RouteConfig(
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
class MainScreen extends _i25.PageRouteInfo<void> {
  const MainScreen({List<_i25.PageRouteInfo>? children})
      : super(
          MainScreen.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i25.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterRoute extends _i25.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i4.TopUp]
class TopUpRoute extends _i25.PageRouteInfo<void> {
  const TopUpRoute()
      : super(
          TopUpRoute.name,
          path: '/top_up',
        );

  static const String name = 'TopUpRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class BankAccountRoute extends _i25.PageRouteInfo<void> {
  const BankAccountRoute({List<_i25.PageRouteInfo>? children})
      : super(
          BankAccountRoute.name,
          path: '/bank_account',
          initialChildren: children,
        );

  static const String name = 'BankAccountRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class HomeRoute extends _i25.PageRouteInfo<void> {
  const HomeRoute({List<_i25.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class ActivityRoute extends _i25.PageRouteInfo<void> {
  const ActivityRoute({List<_i25.PageRouteInfo>? children})
      : super(
          ActivityRoute.name,
          path: 'activity',
          initialChildren: children,
        );

  static const String name = 'ActivityRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class CreateSheetRoute extends _i25.PageRouteInfo<void> {
  const CreateSheetRoute({List<_i25.PageRouteInfo>? children})
      : super(
          CreateSheetRoute.name,
          path: 'create_sheet',
          initialChildren: children,
        );

  static const String name = 'CreateSheetRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class SheetListRoute extends _i25.PageRouteInfo<void> {
  const SheetListRoute({List<_i25.PageRouteInfo>? children})
      : super(
          SheetListRoute.name,
          path: 'sheet_list',
          initialChildren: children,
        );

  static const String name = 'SheetListRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class ProfileRoute extends _i25.PageRouteInfo<void> {
  const ProfileRoute({List<_i25.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i6.HomeScreen]
class HomeScreen extends _i25.PageRouteInfo<void> {
  const HomeScreen()
      : super(
          HomeScreen.name,
          path: '',
        );

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i7.TestUIPage]
class TestUIRoute extends _i25.PageRouteInfo<void> {
  const TestUIRoute()
      : super(
          TestUIRoute.name,
          path: 'test_ui',
        );

  static const String name = 'TestUIRoute';
}

/// generated route for
/// [_i8.DetailSheet]
class DetailSheetRoute extends _i25.PageRouteInfo<DetailSheetRouteArgs> {
  DetailSheetRoute({
    _i26.Key? key,
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

  final _i26.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'DetailSheetRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i9.ReadSheet]
class ReadSheetRoute extends _i25.PageRouteInfo<ReadSheetRouteArgs> {
  ReadSheetRoute({
    _i26.Key? key,
    required String sheetId,
    required _i27.File file,
  }) : super(
          ReadSheetRoute.name,
          path: ':sheetId/read_sheet',
          args: ReadSheetRouteArgs(
            key: key,
            sheetId: sheetId,
            file: file,
          ),
          rawPathParams: {'sheetId': sheetId},
        );

  static const String name = 'ReadSheetRoute';
}

class ReadSheetRouteArgs {
  const ReadSheetRouteArgs({
    this.key,
    required this.sheetId,
    required this.file,
  });

  final _i26.Key? key;

  final String sheetId;

  final _i27.File file;

  @override
  String toString() {
    return 'ReadSheetRouteArgs{key: $key, sheetId: $sheetId, file: $file}';
  }
}

/// generated route for
/// [_i10.AskQuestion]
class AskQuestionRoute extends _i25.PageRouteInfo<AskQuestionRouteArgs> {
  AskQuestionRoute({
    _i26.Key? key,
    required String sheetId,
  }) : super(
          AskQuestionRoute.name,
          path: ':sheetId/read_sheet/ask_question',
          args: AskQuestionRouteArgs(
            key: key,
            sheetId: sheetId,
          ),
          rawPathParams: {'sheetId': sheetId},
        );

  static const String name = 'AskQuestionRoute';
}

class AskQuestionRouteArgs {
  const AskQuestionRouteArgs({
    this.key,
    required this.sheetId,
  });

  final _i26.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'AskQuestionRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i11.CreateQuestion]
class CreateQuestionRoute extends _i25.PageRouteInfo<void> {
  const CreateQuestionRoute()
      : super(
          CreateQuestionRoute.name,
          path: ':sheetId/read_sheet/ask_question/create_question',
        );

  static const String name = 'CreateQuestionRoute';
}

/// generated route for
/// [_i12.DetailQuestion]
class DetailQuestionRoute extends _i25.PageRouteInfo<DetailQuestionRouteArgs> {
  DetailQuestionRoute({
    _i26.Key? key,
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

  final _i26.Key? key;

  final String sheetId;

  final String questionId;

  @override
  String toString() {
    return 'DetailQuestionRouteArgs{key: $key, sheetId: $sheetId, questionId: $questionId}';
  }
}

/// generated route for
/// [_i13.ReviewSheet]
class ReviewSheetRoute extends _i25.PageRouteInfo<ReviewSheetRouteArgs> {
  ReviewSheetRoute({
    _i26.Key? key,
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

  final _i26.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'ReviewSheetRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i14.CreateReview]
class CreateReviewRoute extends _i25.PageRouteInfo<CreateReviewRouteArgs> {
  CreateReviewRoute({
    _i26.Key? key,
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

  final _i26.Key? key;

  final String sheetId;

  @override
  String toString() {
    return 'CreateReviewRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i15.ActivityScreen]
class ActivityScreen extends _i25.PageRouteInfo<void> {
  const ActivityScreen()
      : super(
          ActivityScreen.name,
          path: '',
        );

  static const String name = 'ActivityScreen';
}

/// generated route for
/// [_i16.CreateSheetScreen]
class CreateSheetScreen extends _i25.PageRouteInfo<void> {
  const CreateSheetScreen()
      : super(
          CreateSheetScreen.name,
          path: '',
        );

  static const String name = 'CreateSheetScreen';
}

/// generated route for
/// [_i17.CreateDetailSheet]
class CreateDetailSheetRoute extends _i25.PageRouteInfo<void> {
  const CreateDetailSheetRoute()
      : super(
          CreateDetailSheetRoute.name,
          path: 'create_detail_sheet',
        );

  static const String name = 'CreateDetailSheetRoute';
}

/// generated route for
/// [_i18.ViewImportSheet]
class ViewImportSheetRoute
    extends _i25.PageRouteInfo<ViewImportSheetRouteArgs> {
  ViewImportSheetRoute({
    _i26.Key? key,
    required _i27.File file,
  }) : super(
          ViewImportSheetRoute.name,
          path: 'view_import_sheet',
          args: ViewImportSheetRouteArgs(
            key: key,
            file: file,
          ),
        );

  static const String name = 'ViewImportSheetRoute';
}

class ViewImportSheetRouteArgs {
  const ViewImportSheetRouteArgs({
    this.key,
    required this.file,
  });

  final _i26.Key? key;

  final _i27.File file;

  @override
  String toString() {
    return 'ViewImportSheetRouteArgs{key: $key, file: $file}';
  }
}

/// generated route for
/// [_i19.SheetListScreen]
class SheetListScreen extends _i25.PageRouteInfo<void> {
  const SheetListScreen()
      : super(
          SheetListScreen.name,
          path: '',
        );

  static const String name = 'SheetListScreen';
}

/// generated route for
/// [_i20.ProfileScreen]
class ProfileScreen extends _i25.PageRouteInfo<void> {
  const ProfileScreen()
      : super(
          ProfileScreen.name,
          path: '',
        );

  static const String name = 'ProfileScreen';
}

/// generated route for
/// [_i21.EditProfile]
class EditProfileRoute extends _i25.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i26.Key? key,
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

  final _i26.Key? key;

  final String userId;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i22.BankAccount]
class BankAccount extends _i25.PageRouteInfo<void> {
  const BankAccount()
      : super(
          BankAccount.name,
          path: '',
        );

  static const String name = 'BankAccount';
}

/// generated route for
/// [_i23.AddPaymentMethods]
class AddPaymentMethodsRoute extends _i25.PageRouteInfo<void> {
  const AddPaymentMethodsRoute()
      : super(
          AddPaymentMethodsRoute.name,
          path: 'add_payment_methods',
        );

  static const String name = 'AddPaymentMethodsRoute';
}

/// generated route for
/// [_i24.AddCard]
class AddCardRoute extends _i25.PageRouteInfo<void> {
  const AddCardRoute()
      : super(
          AddCardRoute.name,
          path: 'add_payment_methods/add_card',
        );

  static const String name = 'AddCardRoute';
}
