import 'package:cheat_sheet/res/components/custom_appbar.dart';
import 'package:cheat_sheet/res/components/bottom_bar.dart';
import 'package:cheat_sheet/res/components/sidebar_menu.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../activity_screen.dart';
import '../createSheet_screen.dart';
import '../home_screen.dart';
import '../profile_screen.dart';
import '../sheetList_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final bool user = true;
  int pageIndex = 0;

  static final List<Widget> pageList = <Widget>[
    HomeScreen(),
    ActivityScreen(),
    CreateSheetScreen(),
    SheetListScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        key: Key("value"),
      ),
      endDrawer: SidebarMenu(),
      bottomNavigationBar: BottomBar(),
    );
  }
}
