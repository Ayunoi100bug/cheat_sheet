import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Text('นี่คือหน้าบัญชีของชั้น ไม่ใช่ของใคร แล้วเทอจะทำมัยๆๆๆๆ'),
            ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).push(ChangeEmailRoute());
              },
              child: Text('เปลี่ยนเมลล์จรื้อ'),
            ),
            ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).push(ChangePasswordRoute());
              },
              child: Text('เปลี่ยนรหัสค้าบ'),
            ),
          ],
        ),
      )),
    );
  }
}
