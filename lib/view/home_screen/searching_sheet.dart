import 'package:flutter/material.dart';

class SearchingSheet extends StatefulWidget {
  const SearchingSheet({super.key});

  @override
  State<SearchingSheet> createState() => _SearchingSheetState();
}

class _SearchingSheetState extends State<SearchingSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('นี่คือหน้าการค้นหา')),
    );
  }
}
