import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    required Key key,
    Color backgroundColor: Colors.greenAccent,
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            //เปลี่ยน
            icon: Icon(FluentSystemIcons.ic_fluent_backward_regular),
            onPressed: () {
              print("Logo");
            },
          ),
        );
}


/*
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool user = false;

  const CustomAppBar({
    required Key key,
  }) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.greenAccent,
      elevation: 0,
      title: Text("Logo"),
    );
  }
}
*/