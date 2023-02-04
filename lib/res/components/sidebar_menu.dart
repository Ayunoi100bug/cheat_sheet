import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';

import 'package:cheat_sheet/view_model/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../gap_dimension.dart';
import 'drawer_list.dart';

import '../gap_dimension.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({super.key});

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  AuthService myAuth = AuthService();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
            child: LayoutBuilder(builder: (context, constraints) {
              return Drawer(
                child: ListView(
                  children: [
                    Image.asset('assets/images/logo.png',
                        height: isPortrait
                            ? constraints.maxHeight * 0.2
                            : constraints.maxHeight * 0.4),
                    SizedBox(
                      height: isPortrait ? constraints.maxHeight * 0.7 : null,
                      child: Column(
                        children: [
                          CustomListTile(
                            icon: Icons.notifications_active_outlined,
                            title: 'ตั้งค่าการแจ้งเตือน',
                            onTap: () {},
                          ),
                          CustomListTile(
                            icon: FluentSystemIcons.ic_fluent_shield_regular,
                            title: 'บัญชีของฉัน',
                            onTap: () {
                              print("account");
                            },
                          ),
                          CustomListTile(
                            icon: FluentSystemIcons.ic_fluent_bank_regular,
                            title: 'ข้อมูลบัญชีธนาคาร',
                            onTap: () {
                              print("bank");
                            },
                          ),
                          CustomListTile(
                            icon: Icons.receipt_outlined,
                            title: 'ประวัติการจ่ายเงิน',
                            onTap: () {
                              print("history");
                            },
                          ),
                          CustomListTile(
                            icon: FontAwesomeIcons.coins,
                            title: 'เติมเงิน',
                            onTap: () {
                              Navigator.pop(context);
                              AutoRouter.of(context).push(TopUpRoute());
                            },
                          ),
                          CustomListTile(
                            icon: Icons.cast_for_education_outlined,
                            title: 'แนะนำการใช้งาน',
                            onTap: () {
                              print("guide");
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            Icons.logout_outlined,
                            color: AppColors.error500,
                          ),
                          Medium20px(
                            text: 'ออกจากระบบ',
                            color: AppColors.error500,
                          ),
                        ],
                      ),
                      onTap: () {
                        myAuth.logOut();
                        AutoRouter.of(context).navigateNamed("/home/");
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            }),
          );
        } else {
          return SafeArea(
            child: LayoutBuilder(builder: (context, constraints) {
              return Drawer(
                child: ListView(
                  children: [
                    Image.asset('assets/images/logo.png',
                        height: isPortrait
                            ? constraints.maxHeight * 0.2
                            : constraints.maxHeight * 0.4),
                    SizedBox(
                      height: isPortrait ? constraints.maxHeight * 0.7 : null,
                      child: Column(
                        children: [
                          CustomListTile(
                            icon: Icons.notifications_active_outlined,
                            title: 'ตั้งค่าการแจ้งเตือน',
                            onTap: () {},
                          ),
                          CustomListTile(
                            icon: FluentSystemIcons.ic_fluent_shield_regular,
                            title: 'บัญชีของฉัน',
                            onTap: () {
                              print("account");
                            },
                          ),
                          CustomListTile(
                            icon: FluentSystemIcons.ic_fluent_bank_regular,
                            title: 'ข้อมูลบัญชีธนาคาร',
                            onTap: () {
                              print("bank");
                            },
                          ),
                          CustomListTile(
                            icon: Icons.receipt_outlined,
                            title: 'ประวัติการจ่ายเงิน',
                            onTap: () {
                              print("history");
                            },
                          ),
                          CustomListTile(
                            icon: FontAwesomeIcons.coins,
                            title: 'เติมเงิน',
                            onTap: () {
                              Navigator.pop(context);
                              AutoRouter.of(context).push(TopUpRoute());
                            },
                          ),
                          CustomListTile(
                            icon: Icons.cast_for_education_outlined,
                            title: 'แนะนำการใช้งาน',
                            onTap: () {
                              print("guide");
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Medium20px(
                            text: 'เข้าสู่ระบบ',
                            color: AppColors.tertiary600,
                          ),
                          Icon(
                            Icons.login_outlined,
                            color: AppColors.tertiary600,
                          ),
                        ],
                      ),
                      onTap: () {
                        AutoRouter.of(context).push(LoginRoute());
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            }),
          );
        }
      },
    );
  }
}
