import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';

class ReadSheet extends StatefulWidget {
  final int sheetId;
  const ReadSheet({super.key, @PathParam() required this.sheetId});

  @override
  State<ReadSheet> createState() => _ReadSheetState();
}

class _ReadSheetState extends State<ReadSheet> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: Column(
        children: [
          Text('This is Read Sheet Page of Sheet number ' +
              widget.sheetId.toString()),
          InkWell(
            child: Text('Ask Question'),
            onTap: () {
              AutoRouter.of(context)
                  .push(AskQuestionRoute(sheetId: widget.sheetId));
            },
          )
        ],
      ),
    );
  }
}
