import 'package:auto_route/annotations.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:cheat_sheet/view/create_sheet_screen/create_detail_sheet.dart';
import 'package:cheat_sheet/view/create_sheet_screen/import_sheet_screen.dart';
import 'package:cheat_sheet/view/create_sheet_screen/pick_demo_pages.dart';
import 'package:cheat_sheet/view/create_sheet_screen/view_import_sheet.dart';
import 'package:cheat_sheet/view/home_screen/question/ask_question.dart';
import 'package:cheat_sheet/view/home_screen/question/create_question.dart';
import 'package:cheat_sheet/view/home_screen/create_review.dart';
import 'package:cheat_sheet/view/home_screen/question/detail_question.dart';
import 'package:cheat_sheet/view/home_screen/detail_sheet.dart';
import 'package:cheat_sheet/view/home_screen/read_sheet.dart';
import 'package:cheat_sheet/view/home_screen/review_sheet.dart';
import 'package:cheat_sheet/view/home_screen/searching_sheet.dart';
import 'package:cheat_sheet/view/login.dart';
import 'package:cheat_sheet/view/main_screen.dart';
import 'package:cheat_sheet/view/home_screen/home_screen.dart';
import 'package:cheat_sheet/view/activity_screen/activity_screen.dart';
import 'package:cheat_sheet/view/profile_screen/edit_profile.dart';
import 'package:cheat_sheet/view/profile_screen/profile_screen.dart';
import 'package:cheat_sheet/view/register.dart';
import 'package:cheat_sheet/view/sheet_list_screen/sheet_list_detail.dart';
import 'package:cheat_sheet/view/sheet_list_screen/sheet_list_screen.dart';
import 'package:cheat_sheet/view/side_bar_menu/bank_account/add_card.dart';
import 'package:cheat_sheet/view/side_bar_menu/bank_account/add_payment_methods.dart';
import 'package:cheat_sheet/view/side_bar_menu/bank_account/bank_account.dart';
import 'package:cheat_sheet/view/side_bar_menu/my_account/change_email.dart';
import 'package:cheat_sheet/view/side_bar_menu/my_account/change_password.dart';
import 'package:cheat_sheet/view/side_bar_menu/my_account/my_account.dart';
import 'package:cheat_sheet/view/side_bar_menu/notification_setting.dart';
import 'package:cheat_sheet/view/side_bar_menu/top_up.dart';
import 'package:cheat_sheet/view/test_ui_book.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute(
    path: '/',
    page: MainScreen,
    children: [
      AutoRoute(path: 'home', name: 'HomeRoute', page: EmptyRouterPage, children: [
        AutoRoute(path: '', page: HomeScreen),
        AutoRoute(path: 'test_ui', name: 'TestUIRoute', page: TestUIPage),
        AutoRoute(path: 'searching', name: 'SearchingSheetRoute', page: SearchingSheet),
        AutoRoute(path: ':sheetId', name: 'DetailSheetRoute', page: DetailSheet),
        AutoRoute(path: ':sheetId/read_sheet', name: 'ReadSheetRoute', page: ReadSheet),
        AutoRoute(path: ':sheetId/read_sheet/ask_question', name: 'AskQuestionRoute', page: AskQuestion),
        AutoRoute(path: ':sheetId/read_sheet/ask_question/create_question', name: 'CreateQuestionRoute', page: CreateQuestion),
        AutoRoute(path: ':sheetId/read_sheet/ask_question/:questionId', name: 'DetailQuestionRoute', page: DetailQuestion),
        AutoRoute(path: ':sheetId/review_sheet', name: 'ReviewSheetRoute', page: ReviewSheet),
        AutoRoute(path: ':sheetId/create_review', name: 'CreateReviewRoute', page: CreateReview),
      ]),
      AutoRoute(path: 'activity', name: 'ActivityRoute', page: EmptyRouterPage, children: [
        AutoRoute(path: '', page: ActivityScreen),
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
  AutoRoute(path: '/notification_setting', name: 'NotificationSettingRoute', page: NotificationSetting),
  AutoRoute(path: '/my_account', name: 'MyAccountRoute', page: EmptyRouterPage, children: [
    AutoRoute(path: '', page: MyAccount),
    AutoRoute(path: 'change_email', name: 'ChangeEmailRoute', page: ChangeEmail),
    AutoRoute(path: 'change_password', name: 'ChangePasswordRoute', page: ChangePassword),
  ]),
  AutoRoute(path: '/top_up', name: 'TopUpRoute', page: TopUp),
  AutoRoute(path: '/bank_account', name: 'BankAccountRoute', page: EmptyRouterPage, children: [
    AutoRoute(path: '', page: BankAccount),
    AutoRoute(path: 'add_payment_methods', name: 'AddPaymentMethodsRoute', page: AddPaymentMethods),
    AutoRoute(path: 'add_payment_methods/add_card', name: 'AddCardRoute', page: AddCard)
  ]),
])
class $AppRouter {}
