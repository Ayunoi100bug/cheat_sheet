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
        child: Text('Detail Sheet'),
      )),
    );
  }
}
