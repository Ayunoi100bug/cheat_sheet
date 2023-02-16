import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/bottom_bar.dart';
import 'package:cheat_sheet/res/components/custom_appbar.dart';
import 'package:cheat_sheet/res/components/sidebar_menu.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          const message = 'Press back again to exit';
          //custom your notification here.
          Fluttertoast.showToast(msg: message, fontSize: 18);
          return false;
        }
        Fluttertoast.cancel();
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: const SidebarMenu(),
        body: AutoTabsScaffold(
          appBarBuilder: (context, tabsRouter) => AppBar(
            leading: const AutoLeadingButton(),
            backgroundColor: CustomAppBar.appBarColor,
            title: CustomAppBar.textLogo,
            actions: [
              CustomAppBar.coin,
              CustomAppBar.notifications,
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
              ),
            ],
          ),
          routes: const [
            HomeRoute(),
            ActivityRoute(),
            CreateSheetRoute(),
            SheetListRoute(),
            ProfileRoute(),
          ],
          bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
            items: BottomBar.listItemBottomBar,
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            elevation: BottomBar.elevation,
            showSelectedLabels: BottomBar.showSelectedLabels,
            showUnselectedLabels: BottomBar.showUnselectedLabels,
            type: BottomBar.bottomNavigationBarType,
            selectedItemColor: BottomBar.selectedItemColor,
            unselectedItemColor: BottomBar.unSelectedItemColor,
          ),
        ),
      ),
    );
  }
}
