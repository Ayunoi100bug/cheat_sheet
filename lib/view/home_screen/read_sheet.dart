import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';

class ReadSheet extends StatefulWidget {
  const ReadSheet({super.key});

  @override
  State<ReadSheet> createState() => _ReadSheetState();
}

class _ReadSheetState extends State<ReadSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Read Sheet'),
          InkWell(
            child: Text('Ask Question'),
            onTap: () {
              AutoRouter.of(context).push(AskQuestionRoute());
            },
          )
        ],
      ),
    );
  }
}
