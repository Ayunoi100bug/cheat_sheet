import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('นี่ก็ครือหน้าเปลี่ยนรหัสผ่านของคนขี้ลืมแบบแกรยังไงล้า'),
      )),
    );
  }
}
