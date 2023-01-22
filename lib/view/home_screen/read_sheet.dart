import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';

class ReadSheet extends StatefulWidget {
  final int sheetId;
  const ReadSheet({super.key, @PathParam() required this.sheetId});

  @override
  State<ReadSheet> createState() => _ReadSheetState();
}

class _ReadSheetState extends State<ReadSheet> {
  @override
  Widget build(BuildContext context) {
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
