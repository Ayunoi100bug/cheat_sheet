import 'package:flutter/material.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            'นี่คือหน้าการแจ้งเตือนตัวเองเอาไว้ ที่เทอเรียกชั้นลำไย~ ฉันเก็บเอาไว้ในใจเรื่อยมา'),
      ),
    );
  }
}
