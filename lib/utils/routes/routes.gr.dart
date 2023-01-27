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
import 'dart:io' as _i23;

import 'package:auto_route/auto_route.dart' as _i21;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:flutter/material.dart' as _i22;

import '../../view/activity_screen/activity_screen.dart' as _i14;
import '../../view/create_sheet_screen/create_detail_sheet.dart' as _i16;
import '../../view/create_sheet_screen/create_sheet_screen.dart' as _i15;
import '../../view/create_sheet_screen/view_import_sheet.dart' as _i17;
import '../../view/home_screen/ask_question.dart' as _i9;
import '../../view/home_screen/create_question.dart' as _i10;
import '../../view/home_screen/create_review.dart' as _i13;
import '../../view/home_screen/detail_question.dart' as _i11;
import '../../view/home_screen/detail_sheet.dart' as _i7;
import '../../view/home_screen/home_screen.dart' as _i5;
import '../../view/home_screen/read_sheet.dart' as _i8;
import '../../view/home_screen/review_sheet.dart' as _i12;
import '../../view/login.dart' as _i2;
import '../../view/main_screen.dart' as _i1;
import '../../view/profile_screen/edit_profile.dart' as _i20;
import '../../view/profile_screen/profile_screen.dart' as _i19;
import '../../view/register.dart' as _i3;
import '../../view/sheet_list_screen/sheet_list_screen.dart' as _i18;
import '../../view/test_ui_book.dart' as _i6;

class AppRouter extends _i21.RootStackRouter {
  AppRouter([_i22.GlobalKey<_i22.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i21.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MainScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ActivityRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    CreateSheetRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    SheetListRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    HomeScreen.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.HomeScreen(),
      );
    },
    TestUIRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.TestUIPage(),
      );
    },
    DetailSheetRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DetailSheetRouteArgs>(
          orElse: () =>
              DetailSheetRouteArgs(sheetId: pathParams.getInt('sheetId')));
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.DetailSheet(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    ReadSheetRoute.name: (routeData) {
      final args = routeData.argsAs<ReadSheetRouteArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.ReadSheet(
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
              AskQuestionRouteArgs(sheetId: pathParams.get('sheetId')));
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.AskQuestion(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    CreateQuestionRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.CreateQuestion(),
      );
    },
    DetailQuestionRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DetailQuestionRouteArgs>(
          orElse: () => DetailQuestionRouteArgs(
                sheetId: pathParams.getInt('sheetId'),
                questionId: pathParams.getInt('questionId'),
              ));
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.DetailQuestion(
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
              ReviewSheetRouteArgs(sheetId: pathParams.getInt('sheetId')));
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.ReviewSheet(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    CreateReviewRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CreateReviewRouteArgs>(
          orElse: () =>
              CreateReviewRouteArgs(sheetId: pathParams.getInt('sheetId')));
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.CreateReview(
          key: args.key,
          sheetId: args.sheetId,
        ),
      );
    },
    ActivityScreen.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.ActivityScreen(),
      );
    },
    CreateSheetScreen.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.CreateSheetScreen(),
      );
    },
    CreateDetailSheetRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.CreateDetailSheet(),
      );
    },
    ViewImportSheetRoute.name: (routeData) {
      final args = routeData.argsAs<ViewImportSheetRouteArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.ViewImportSheet(
          key: args.key,
          file: args.file,
        ),
      );
    },
    SheetListScreen.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i18.SheetListScreen(),
      );
    },
    ProfileScreen.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i19.ProfileScreen(),
      );
    },
    EditProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditProfileRouteArgs>(
          orElse: () =>
              EditProfileRouteArgs(userId: pathParams.getString('userId')));
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i20.EditProfile(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
  };

  @override
  List<_i21.RouteConfig> get routes => [
        _i21.RouteConfig(
          MainScreen.name,
          path: '/',
          children: [
            _i21.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainScreen.name,
              children: [
                _i21.RouteConfig(
                  HomeScreen.name,
                  path: '',
                  parent: HomeRoute.name,
                ),
                _i21.RouteConfig(
                  TestUIRoute.name,
                  path: 'test_ui',
                  parent: HomeRoute.name,
                ),
                _i21.RouteConfig(
                  DetailSheetRoute.name,
                  path: ':sheetId',
                  parent: HomeRoute.name,
                ),
                _i21.RouteConfig(
                  ReadSheetRoute.name,
                  path: ':sheetId/read_sheet',
                  parent: HomeRoute.name,
                ),
                _i21.RouteConfig(
                  AskQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question',
                  parent: HomeRoute.name,
                ),
                _i21.RouteConfig(
                  CreateQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question/create_question',
                  parent: HomeRoute.name,
                ),
                _i21.RouteConfig(
                  DetailQuestionRoute.name,
                  path: ':sheetId/read_sheet/ask_question/:questionId',
                  parent: HomeRoute.name,
                ),
                _i21.RouteConfig(
                  ReviewSheetRoute.name,
                  path: ':sheetId/review_sheet',
                  parent: HomeRoute.name,
                ),
                _i21.RouteConfig(
                  CreateReviewRoute.name,
                  path: ':sheetId/create_review',
                  parent: HomeRoute.name,
                ),
              ],
            ),
            _i21.RouteConfig(
              ActivityRoute.name,
              path: 'activity',
              parent: MainScreen.name,
              children: [
                _i21.RouteConfig(
                  ActivityScreen.name,
                  path: '',
                  parent: ActivityRoute.name,
                )
              ],
            ),
            _i21.RouteConfig(
              CreateSheetRoute.name,
              path: 'create_sheet',
              parent: MainScreen.name,
              children: [
                _i21.RouteConfig(
                  CreateSheetScreen.name,
                  path: '',
                  parent: CreateSheetRoute.name,
                ),
                _i21.RouteConfig(
                  CreateDetailSheetRoute.name,
                  path: 'create_detail_sheet',
                  parent: CreateSheetRoute.name,
                ),
                _i21.RouteConfig(
                  ViewImportSheetRoute.name,
                  path: 'view_import_sheet',
                  parent: CreateSheetRoute.name,
                ),
              ],
            ),
            _i21.RouteConfig(
              SheetListRoute.name,
              path: 'sheet_list',
              parent: MainScreen.name,
              children: [
                _i21.RouteConfig(
                  SheetListScreen.name,
                  path: '',
                  parent: SheetListRoute.name,
                )
              ],
            ),
            _i21.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: MainScreen.name,
              children: [
                _i21.RouteConfig(
                  ProfileScreen.name,
                  path: '',
                  parent: ProfileRoute.name,
                ),
                _i21.RouteConfig(
                  EditProfileRoute.name,
                  path: ':userId',
                  parent: ProfileRoute.name,
                ),
              ],
            ),
          ],
        ),
        _i21.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i21.RouteConfig(
          RegisterRoute.name,
          path: '/register',
        ),
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreen extends _i21.PageRouteInfo<void> {
  const MainScreen({List<_i21.PageRouteInfo>? children})
      : super(
          MainScreen.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i21.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterRoute extends _i21.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class HomeRoute extends _i21.PageRouteInfo<void> {
  const HomeRoute({List<_i21.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ActivityRoute extends _i21.PageRouteInfo<void> {
  const ActivityRoute({List<_i21.PageRouteInfo>? children})
      : super(
          ActivityRoute.name,
          path: 'activity',
          initialChildren: children,
        );

  static const String name = 'ActivityRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class CreateSheetRoute extends _i21.PageRouteInfo<void> {
  const CreateSheetRoute({List<_i21.PageRouteInfo>? children})
      : super(
          CreateSheetRoute.name,
          path: 'create_sheet',
          initialChildren: children,
        );

  static const String name = 'CreateSheetRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class SheetListRoute extends _i21.PageRouteInfo<void> {
  const SheetListRoute({List<_i21.PageRouteInfo>? children})
      : super(
          SheetListRoute.name,
          path: 'sheet_list',
          initialChildren: children,
        );

  static const String name = 'SheetListRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ProfileRoute extends _i21.PageRouteInfo<void> {
  const ProfileRoute({List<_i21.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i5.HomeScreen]
class HomeScreen extends _i21.PageRouteInfo<void> {
  const HomeScreen()
      : super(
          HomeScreen.name,
          path: '',
        );

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i6.TestUIPage]
class TestUIRoute extends _i21.PageRouteInfo<void> {
  const TestUIRoute()
      : super(
          TestUIRoute.name,
          path: 'test_ui',
        );

  static const String name = 'TestUIRoute';
}

/// generated route for
/// [_i7.DetailSheet]
class DetailSheetRoute extends _i21.PageRouteInfo<DetailSheetRouteArgs> {
  DetailSheetRoute({
    _i22.Key? key,
    required int sheetId,
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

  final _i22.Key? key;

  final int sheetId;

  @override
  String toString() {
    return 'DetailSheetRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i8.ReadSheet]
class ReadSheetRoute extends _i21.PageRouteInfo<ReadSheetRouteArgs> {
  ReadSheetRoute({
    _i22.Key? key,
    required int sheetId,
    required _i23.File file,
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

  final _i22.Key? key;

  final int sheetId;

  final _i23.File file;

  @override
  String toString() {
    return 'ReadSheetRouteArgs{key: $key, sheetId: $sheetId, file: $file}';
  }
}

/// generated route for
/// [_i9.AskQuestion]
class AskQuestionRoute extends _i21.PageRouteInfo<AskQuestionRouteArgs> {
  AskQuestionRoute({
    _i22.Key? key,
    required dynamic sheetId,
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

  final _i22.Key? key;

  final dynamic sheetId;

  @override
  String toString() {
    return 'AskQuestionRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i10.CreateQuestion]
class CreateQuestionRoute extends _i21.PageRouteInfo<void> {
  const CreateQuestionRoute()
      : super(
          CreateQuestionRoute.name,
          path: ':sheetId/read_sheet/ask_question/create_question',
        );

  static const String name = 'CreateQuestionRoute';
}

/// generated route for
/// [_i11.DetailQuestion]
class DetailQuestionRoute extends _i21.PageRouteInfo<DetailQuestionRouteArgs> {
  DetailQuestionRoute({
    _i22.Key? key,
    required int sheetId,
    required int questionId,
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

  final _i22.Key? key;

  final int sheetId;

  final int questionId;

  @override
  String toString() {
    return 'DetailQuestionRouteArgs{key: $key, sheetId: $sheetId, questionId: $questionId}';
  }
}

/// generated route for
/// [_i12.ReviewSheet]
class ReviewSheetRoute extends _i21.PageRouteInfo<ReviewSheetRouteArgs> {
  ReviewSheetRoute({
    _i22.Key? key,
    required int sheetId,
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

  final _i22.Key? key;

  final int sheetId;

  @override
  String toString() {
    return 'ReviewSheetRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i13.CreateReview]
class CreateReviewRoute extends _i21.PageRouteInfo<CreateReviewRouteArgs> {
  CreateReviewRoute({
    _i22.Key? key,
    required int sheetId,
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

  final _i22.Key? key;

  final int sheetId;

  @override
  String toString() {
    return 'CreateReviewRouteArgs{key: $key, sheetId: $sheetId}';
  }
}

/// generated route for
/// [_i14.ActivityScreen]
class ActivityScreen extends _i21.PageRouteInfo<void> {
  const ActivityScreen()
      : super(
          ActivityScreen.name,
          path: '',
        );

  static const String name = 'ActivityScreen';
}

/// generated route for
/// [_i15.CreateSheetScreen]
class CreateSheetScreen extends _i21.PageRouteInfo<void> {
  const CreateSheetScreen()
      : super(
          CreateSheetScreen.name,
          path: '',
        );

  static const String name = 'CreateSheetScreen';
}

/// generated route for
/// [_i16.CreateDetailSheet]
class CreateDetailSheetRoute extends _i21.PageRouteInfo<void> {
  const CreateDetailSheetRoute()
      : super(
          CreateDetailSheetRoute.name,
          path: 'create_detail_sheet',
        );

  static const String name = 'CreateDetailSheetRoute';
}

/// generated route for
/// [_i17.ViewImportSheet]
class ViewImportSheetRoute
    extends _i21.PageRouteInfo<ViewImportSheetRouteArgs> {
  ViewImportSheetRoute({
    _i22.Key? key,
    required _i23.File file,
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

  final _i22.Key? key;

  final _i23.File file;

  @override
  String toString() {
    return 'ViewImportSheetRouteArgs{key: $key, file: $file}';
  }
}

/// generated route for
/// [_i18.SheetListScreen]
class SheetListScreen extends _i21.PageRouteInfo<void> {
  const SheetListScreen()
      : super(
          SheetListScreen.name,
          path: '',
        );

  static const String name = 'SheetListScreen';
}

/// generated route for
/// [_i19.ProfileScreen]
class ProfileScreen extends _i21.PageRouteInfo<void> {
  const ProfileScreen()
      : super(
          ProfileScreen.name,
          path: '',
        );

  static const String name = 'ProfileScreen';
}

/// generated route for
/// [_i20.EditProfile]
class EditProfileRoute extends _i21.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i22.Key? key,
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

  final _i22.Key? key;

  final String userId;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, userId: $userId}';
  }
}
