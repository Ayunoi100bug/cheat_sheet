import 'package:auto_route/annotations.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:cheat_sheet/res/components/tools_bar/color_picker_page.dart';
import 'package:cheat_sheet/view/about_grade.dart';
import 'package:cheat_sheet/view/about_subject.dart';
import 'package:cheat_sheet/view/activity_screen/all_achievement.dart';
import 'package:cheat_sheet/view/create_sheet_screen/create_detail_sheet.dart';
import 'package:cheat_sheet/view/create_sheet_screen/import_sheet_screen.dart';
import 'package:cheat_sheet/view/create_sheet_screen/pick_demo_pages.dart';
import 'package:cheat_sheet/view/create_sheet_screen/view_import_sheet.dart';
import 'package:cheat_sheet/view/home_screen/edit_sheet.dart';
import 'package:cheat_sheet/view/home_screen/question/ask_question.dart';
import 'package:cheat_sheet/view/home_screen/question/create_question.dart';
import 'package:cheat_sheet/view/home_screen/create_review.dart';
import 'package:cheat_sheet/view/home_screen/question/detail_question.dart';
import 'package:cheat_sheet/view/home_screen/detail_sheet.dart';
import 'package:cheat_sheet/view/home_screen/question/edit_demo.dart';
import 'package:cheat_sheet/view/home_screen/read_sheet.dart';
import 'package:cheat_sheet/view/home_screen/recommend_sheet.dart';
import 'package:cheat_sheet/view/home_screen/review_sheet.dart';
import 'package:cheat_sheet/view/home_screen/searching_sheet.dart';
import 'package:cheat_sheet/view/home_screen/top_sheet.dart';
import 'package:cheat_sheet/view/login.dart';
import 'package:cheat_sheet/view/main_screen.dart';
import 'package:cheat_sheet/view/home_screen/home_screen.dart';
import 'package:cheat_sheet/view/activity_screen/activity_screen.dart';
import 'package:cheat_sheet/view/profile_screen/edit_profile.dart';
import 'package:cheat_sheet/view/home_screen/other_profile.dart';
import 'package:cheat_sheet/view/profile_screen/profile_screen.dart';
import 'package:cheat_sheet/view/register.dart';
import 'package:cheat_sheet/view/sheet_list_screen/sheet_list_detail.dart';
import 'package:cheat_sheet/view/sheet_list_screen/sheet_list_screen.dart';
import 'package:cheat_sheet/view/side_bar_menu/dash_board.dart';
import 'package:cheat_sheet/view/side_bar_menu/my_account/change_email.dart';
import 'package:cheat_sheet/view/side_bar_menu/my_account/change_password.dart';
import 'package:cheat_sheet/view/side_bar_menu/my_account/my_account.dart';
import 'package:cheat_sheet/view/side_bar_menu/top_up.dart';
import 'package:cheat_sheet/view/test_ui_book.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute(
    path: '/',
    page: MainScreen,
    children: [
      AutoRoute(path: 'home', name: 'HomeRoute', page: EmptyRouterPage, children: [
        AutoRoute(path: '', name: 'HomeScreenRoute', page: HomeScreen),
        AutoRoute(path: 'test_ui', name: 'TestUIRoute', page: TestUIPage),
        AutoRoute(path: 'searching', name: 'SearchingSheetRoute', page: SearchingSheet),
        AutoRoute(path: 'recommend_sheet', name: 'RecommendSheetRoute', page: RecommendSheet),
        AutoRoute(path: 'top_sheet', name: 'TopSheetRoute', page: TopSheet),
        AutoRoute(path: 'other_profile/:userId', name: 'OtherProfileRoute', page: OtherProfile),
        AutoRoute(path: ':sheetId', name: 'DetailSheetRoute', page: DetailSheet),
        AutoRoute(path: ':sheetId/read_sheet', name: 'ReadSheetRoute', page: ReadSheet),
        AutoRoute(path: ':sheetId/read_sheet/ask_question', name: 'AskQuestionRoute', page: AskQuestion),
        AutoRoute(path: ':sheetId/read_sheet/ask_question/create_question', name: 'CreateQuestionRoute', page: CreateQuestion),
        AutoRoute(path: ':sheetId/read_sheet/ask_question/create_question/pick_color', name: 'PickColorRoute', page: ColorPickerPage),
        AutoRoute(path: ':sheetId/read_sheet/ask_question/:questionId', name: 'DetailQuestionRoute', page: DetailQuestion),
        AutoRoute(path: ':sheetId/review_sheet', name: 'ReviewSheetRoute', page: ReviewSheet),
        AutoRoute(path: ':sheetId/create_review', name: 'CreateReviewRoute', page: CreateReview),
        AutoRoute(path: ':sheetId/edit_sheet', name: 'EditSheetRoute', page: EditSheet),
        AutoRoute(path: ':sheetId/edit_sheet/edit_demo', name: 'EditDemoRoute', page: EditDemo),
      ]),
      AutoRoute(path: 'activity', name: 'ActivityRoute', page: EmptyRouterPage, children: [
        AutoRoute(path: '', page: ActivityScreen),
        AutoRoute(path: 'all_achievement', name: 'AllAchievementRoute', page: AllAchievement),
      ]),
      AutoRoute(path: 'create_sheet', name: 'CreateSheetRoute', page: EmptyRouterPage, children: [
        AutoRoute(path: '', page: CreateSheetScreen),
        AutoRoute(path: 'create_detail_sheet', name: 'CreateDetailSheetRoute', page: CreateDetailSheet),
        AutoRoute(path: 'view_import_sheet', name: 'ViewImportSheetRoute', page: ViewImportSheet),
        AutoRoute(path: 'pick_demo_pages', name: 'PickDemoPagesRoute', page: PickDemoPages),
      ]),
      AutoRoute(path: 'sheet_list', name: 'SheetListRoute', page: EmptyRouterPage, children: [
        AutoRoute(path: '', page: SheetListScreen),
        AutoRoute(path: ':sheetId', name: 'SheetListDetailRoute', page: SheetListDetail),
      ]),
      AutoRoute(path: 'profile', name: 'ProfileRoute', page: EmptyRouterPage, children: [
        AutoRoute(path: '', page: ProfileScreen),
        AutoRoute(path: ':userId', name: 'EditProfileRoute', page: EditProfile),
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
  AutoRoute(path: '/my_account', name: 'MyAccountRoute', page: EmptyRouterPage, children: [
    AutoRoute(path: '', page: MyAccount),
    AutoRoute(path: 'change_email', name: 'ChangeEmailRoute', page: ChangeEmail),
    AutoRoute(path: 'change_password', name: 'ChangePasswordRoute', page: ChangePassword),
  ]),
  AutoRoute(path: '/top_up', name: 'TopUpRoute', page: TopUp),
  AutoRoute(path: '/dash_board', name: 'DashBoardRoute', page: DashBoard),
  AutoRoute(path: '/first_login', name: 'FirstLoginRoute', page: EmptyRouterPage, children: [
    AutoRoute(
      path: 'about_subject',
      name: 'AboutSubjectRoute',
      page: AboutSubject,
    ),
    AutoRoute(
      path: 'about_grade',
      name: 'AboutGradeRoute',
      page: AboutGrade,
      initial: true,
    ),
  ]),
])
class $AppRouter {}
