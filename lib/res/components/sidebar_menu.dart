import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/utils/routes/routes_name.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../gap_dimension.dart';
import 'drawer_list.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({super.key});

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      child: ListView(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: screenWidth < 480 ? screenHeight * 0.2 : screenHeight * 0.4,
          ),
          CustomListTile(
            icon: Icons.notifications_active_outlined,
            title: 'ตั้งค่าการแจ้งเตือน',
            onTap: () {
              AutoRouter.of(context).push(LoginRoute());
            },
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
              print("payment");
            },
          ),
          CustomListTile(
            icon: Icons.cast_for_education_outlined,
            title: 'แนะนำการใช้งาน',
            onTap: () {
              print("guide");
            },
          ),
          SizedBox(
            height: screenHeight * 0.36,
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
              print('Lopgin');
            },
          ),
        ],
      ),
    );
  }
}
