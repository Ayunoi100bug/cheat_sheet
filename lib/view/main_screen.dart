import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/bottom_bar.dart';
import 'package:cheat_sheet/res/components/custom_appbar.dart';
import 'package:cheat_sheet/res/components/sidebar_menu.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: SidebarMenu(),
      body: AutoTabsScaffold(
        appBarBuilder: (context, tabsRouter) => AppBar(
          backgroundColor: CustomAppBar.appBarColor,
          title: CustomAppBar.textLogo,
          actions: [
            CustomAppBar.coin,
            CustomAppBar.notifications,
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
            ),
          ],
        ),
        routes: const [
          HomeScreenRoute(),
          ActivityScreenRoute(),
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
    );
  }
}
