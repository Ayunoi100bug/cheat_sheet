import 'package:cheat_sheet/res/components/sidebar_menu.dart';
import 'package:cheat_sheet/view/activity_screen.dart';
import 'package:cheat_sheet/view/createSheet_screen.dart';
import 'package:cheat_sheet/view/home_screen.dart';
import 'package:cheat_sheet/view/profile_screen.dart';
import 'package:cheat_sheet/view/sheetList_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final bool user = true;
  int pageIndex = 0;

  static final List<Widget> pageList = <Widget>[
    HomeScreen(),
    ActivityScreen(),
    CreateSheetScreen(),
    SheetListScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: pageIndex,
      onTap: (value) {
        setState(() {
          if (user == true) {
            pageIndex = value;
          } else if (user == false) {
            print("Go to Login");
          }
        });
      },
      elevation: 10,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.teal,
      unselectedItemColor: const Color(0xFF526480),
      items: const [
        BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_clock_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_clock_filled),
            label: "Activity"),
        BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_document_edit_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_document_edit_filled),
            label: "createSheet"),
        BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_heart_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_heart_filled),
            label: "sheetList"),
        BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
            label: "Profile")
        /*
              icon CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage(""),
              ),
              label: "Profile"),
              */
      ],
    );
  }
}
