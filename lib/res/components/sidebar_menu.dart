import 'package:cheat_sheet/utils/routes/routes_name.dart';
import 'package:cheat_sheet/view/home_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../view/activity_screen.dart';
import '../../view/create_sheet_screen.dart';
import '../../view/profile_screen.dart';
import '../../view/sheet_list_screen.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({super.key});

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Image.network(
            'https://i.pinimg.com/564x/66/54/99/665499c8cd2c5b902e504c7029a2079a.jpg',
            width: 100,
            height: 120,
          ),
          ListTile(
              leading: Icon(FluentSystemIcons.ic_fluent_settings_regular),
              title: Text('ตั้งค่าการแจ้งเตือน'),
              onTap: () {
                Navigator.pushNamed(context, RoutesName.settingNotification);
              }),
          ListTile(
              leading:
                  Icon(FluentSystemIcons.ic_fluent_person_accounts_regular),
              title: Text('บัญชีของฉัน'),
              onTap: () {
                print("account");
              }),
          ListTile(
              leading: Icon(FluentSystemIcons.ic_fluent_bank_regular),
              title: Text('ข้อมูลบัญชีธนาคาร'),
              onTap: () {
                print("bank");
              }),
          ListTile(
              leading: Icon(FluentSystemIcons.ic_fluent_history_regular),
              title: Text('ประวัติการจ่ายเงิน'),
              onTap: () {
                print("history");
              }),
          ListTile(
              leading: Icon(FluentSystemIcons.ic_fluent_payment_regular),
              title: Text('เติมเงิน'),
              onTap: () {
                print("payment");
              }),
          ListTile(
            leading: Icon(FluentSystemIcons.ic_fluent_style_guide_regular),
            title: Text('แนะนำการใช้งาน'),
            onTap: () {
              print("guide");
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                  leading:
                      Icon(FluentSystemIcons.ic_fluent_arrow_enter_regular),
                  title: Text('เข้าสู่ระบบ'),
                  onTap: () {
                    print("Register");
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
