import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';

class DetailSheet extends StatefulWidget {
  const DetailSheet({super.key});

  @override
  State<DetailSheet> createState() => _DetailSheetState();
}

class _DetailSheetState extends State<DetailSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Text('Detail Sheet'),
            InkWell(
              child: Text('Read Sheet'),
              onTap: () {
                AutoRouter.of(context).push(ReadSheetRoute());
              },
            ),
            InkWell(
              child: Text('Review Sheet'),
              onTap: () {
                AutoRouter.of(context).push(ReviewSheetRoute());
              },
            ),
          ],
        ),
      )),
    );
  }
}
