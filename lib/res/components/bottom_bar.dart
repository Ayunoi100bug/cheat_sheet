import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar {
  static List<BottomNavigationBarItem> listItemBottomBar = const [
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
  ];

  static double elevation = 10;

  static bool showSelectedLabels = false;

  static bool showUnselectedLabels = false;

  static BottomNavigationBarType bottomNavigationBarType =
      BottomNavigationBarType.fixed;

  static Color selectedItemColor = Colors.teal;

  static Color unSelectedItemColor = const Color(0xFF526480);
}
