import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          child: Text('I am ปุ่มกด'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => SafeArea(
                  child: Container(
                    child: InkWell(
                      child: Text('I am ปดกุ่ม'),
                      onTap: () {
                        AutoRouter.of(context).push(LoginRoute());
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
