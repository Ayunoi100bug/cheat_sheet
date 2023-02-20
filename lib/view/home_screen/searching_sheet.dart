import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';

import '../../data/network/pdf_api.dart';
import '../../res/button.dart';
import '../../res/components/flushbar.dart';
import '../../res/components/sheet.dart';
import '../../utils/routes/routes.gr.dart';
import '../../view_model/file_passer.dart';

class SearchingSheet extends StatefulWidget {
  const SearchingSheet({super.key});

  @override
  State<SearchingSheet> createState() => _SearchingSheetState();
}

class _SearchingSheetState extends State<SearchingSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(child: const Text("SearchingSheet"));
  }
}
