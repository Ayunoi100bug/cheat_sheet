import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/bottom_bar.dart';
import 'package:cheat_sheet/res/components/custom_appbar.dart';
import 'package:cheat_sheet/res/components/sidebar_menu.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
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
      child: StreamBuilder(
          stream: _auth.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (!snapshot.hasData) {
              return StreamBuilder<DocumentSnapshot>(
                  stream: _firestore.collection("users").doc(_auth.currentUser?.uid).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    return Scaffold(
                      key: _scaffoldKey,
                      endDrawer: const SidebarMenu(),
                      body: AutoTabsScaffold(
                        appBarBuilder: (context, tabsRouter) => AppBar(
                          leading: const AutoLeadingButton(),
                          backgroundColor: CustomAppBar.appBarColor,
                          title: CustomAppBar.textLogo,
                          actions: [
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
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return StreamBuilder<DocumentSnapshot>(
                stream: _firestore.collection("users").doc(_auth.currentUser?.uid).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Scaffold(
                    key: _scaffoldKey,
                    endDrawer: const SidebarMenu(),
                    body: AutoTabsScaffold(
                      appBarBuilder: (context, tabsRouter) => AppBar(
                        leading: const AutoLeadingButton(),
                        backgroundColor: CustomAppBar.appBarColor,
                        title: CustomAppBar.textLogo,
                        actions: [
                          Row(
                            children: [
                              CustomAppBar.coin,
                              const SizedBox(width: 4),
                              Regular16px(
                                text: data['coin'].toString(),
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
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
                  );
                });
          }),
    );
  }
}
