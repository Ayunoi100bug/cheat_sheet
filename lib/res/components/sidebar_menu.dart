import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/utils/routes/routes_name.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

import '../gap_dimension.dart';

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
    return SizedBox(
      height: screenHeight,
      child: Drawer(
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: constraints.maxWidth * 0.48,
              ),
              ListTile(
                  leading: Icon(FluentSystemIcons.ic_fluent_settings_regular),
                  title: Medium20px(
                    text: 'ตั้งค่าการแจ้งเตือน',
                    color: AppColors.primary600,
                  ),
                  onTap: () {
                    AutoRouter.of(context).push(LoginRoute());
                  }),
              ListTile(
                  leading:
                      Icon(FluentSystemIcons.ic_fluent_person_accounts_regular),
                  title: Medium20px(
                    text: 'บัญชีของฉัน',
                    color: AppColors.primary600,
                  ),
                  onTap: () {
                    print("account");
                  }),
              ListTile(
                  leading: Icon(FluentSystemIcons.ic_fluent_bank_regular),
                  title: Medium20px(
                    text: 'ข้อมูลบัญชีธนาคาร',
                    color: AppColors.primary600,
                  ),
                  onTap: () {
                    print("bank");
                  }),
              ListTile(
                  leading: Icon(FluentSystemIcons.ic_fluent_history_regular),
                  title: Medium20px(
                    text: 'ประวัติการจ่ายเงิน',
                    color: AppColors.primary600,
                  ),
                  onTap: () {
                    print("history");
                  }),
              ListTile(
                  leading: Icon(FluentSystemIcons.ic_fluent_payment_regular),
                  title: Medium20px(
                    text: 'เติมเงิน',
                    color: AppColors.primary600,
                  ),
                  onTap: () {
                    print("payment");
                  }),
              ListTile(
                leading: Icon(FluentSystemIcons.ic_fluent_style_guide_regular),
                title: Medium20px(
                  text: 'แนะนำการใช้งาน',
                  color: AppColors.primary600,
                ),
                onTap: () {
                  print("guide");
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
