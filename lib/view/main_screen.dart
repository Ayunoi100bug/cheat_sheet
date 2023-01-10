import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/components/bottom_bar.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) => AppBar(),
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
    );
  }
}
