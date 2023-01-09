import 'package:cheat_sheet/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreateSheetScreen extends StatefulWidget {
  const CreateSheetScreen({super.key});

  @override
  State<CreateSheetScreen> createState() => _CreateSheetScreenState();
}

class _CreateSheetScreenState extends State<CreateSheetScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("create sheet"),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
