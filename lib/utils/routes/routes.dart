import 'package:auto_route/annotations.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:cheat_sheet/view/create_sheet_screen/create_detail_sheet.dart';
import 'package:cheat_sheet/view/create_sheet_screen/create_sheet_screen.dart';
import 'package:cheat_sheet/view/home_screen/ask_question.dart';
import 'package:cheat_sheet/view/home_screen/create_question.dart';
import 'package:cheat_sheet/view/home_screen/create_review.dart';
import 'package:cheat_sheet/view/home_screen/detail_sheet.dart';
import 'package:cheat_sheet/view/home_screen/read_sheet.dart';
import 'package:cheat_sheet/view/home_screen/review_sheet.dart';
import 'package:cheat_sheet/view/login.dart';
import 'package:cheat_sheet/view/main_screen.dart';
import 'package:cheat_sheet/view/home_screen/home_screen.dart';
import 'package:cheat_sheet/view/activity_screen/activity_screen.dart';
import 'package:cheat_sheet/view/profile_screen/edit_profile.dart';
import 'package:cheat_sheet/view/profile_screen/profile_screen.dart';
import 'package:cheat_sheet/view/register.dart';
import 'package:cheat_sheet/view/sheet_list_screen/sheet_list_screen.dart';
import 'package:cheat_sheet/view/test_ui_book.dart';

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
            AutoRoute(path: 'test_ui', name: 'TestUIRoute', page: TestUIPage),
            AutoRoute(
                path: ':sheetId', name: 'DetailSheetRoute', page: DetailSheet),
            AutoRoute(
                path: ':sheetId/read_sheet',
                name: 'ReadSheetRoute',
                page: ReadSheet),
            AutoRoute(
                path: ':sheetId/read_sheet/ask_question',
                name: 'AskQuestionRoute',
                page: AskQuestion),
            AutoRoute(
                path: ':sheetId/read_sheet/ask_question/create_question',
                name: 'CreateQuestionRoute',
                page: CreateQuestion),
            AutoRoute(
                path: ':sheetId/review_sheet',
                name: 'ReviewSheetRoute',
                page: ReviewSheet),
            AutoRoute(
                path: ':sheetId/create_review',
                name: 'CreateReviewRoute',
                page: CreateReview),
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
            AutoRoute(
                path: 'create_detail_sheet',
                name: 'CreateDetailSheetRoute',
                page: CreateDetailSheet),
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
            AutoRoute(
                path: ':userId', name: 'EditProfileRoute', page: EditProfile),
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
