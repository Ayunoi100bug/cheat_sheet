import 'package:cheat_sheet/res/components/bottom_bar.dart';
import 'package:cheat_sheet/res/components/custom_appbar.dart';
import 'package:cheat_sheet/res/components/bottom_bar.dart';
import 'package:cheat_sheet/res/components/sidebar_menu.dart';
import 'package:cheat_sheet/view/activity_screen.dart';
import 'package:cheat_sheet/view/create_sheet_screen.dart';
import 'package:cheat_sheet/view/home_screen.dart';
import 'package:cheat_sheet/view/profile_screen.dart';
import 'package:cheat_sheet/view/sheet_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedPageIndex;
  late List<Widget> _pages;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedPageIndex = 0;
    _pages = [
      HomeScreen(),
      ActivityScreen(),
      CreateSheetScreen(),
      SheetListScreen(),
      ProfileScreen(),
    ];
    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: BottomBar.listItemBottomBar,
        elevation: BottomBar.elevation,
        showSelectedLabels: BottomBar.showSelectedLabels,
        showUnselectedLabels: BottomBar.showUnselectedLabels,
        type: BottomBar.bottomNavigationBarType,
        selectedItemColor: BottomBar.selectedItemColor,
        unselectedItemColor: BottomBar.unSelectedItemColor,
        currentIndex: _selectedPageIndex,
        onTap: (selectedPageIndex) {
          setState(() {
            _selectedPageIndex = selectedPageIndex;
            _pageController.jumpToPage(selectedPageIndex);
          });
        },
      ),
    );
  }
}
