import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/cupertino.dart';

class PDFOpenner {
  static void openPDF(BuildContext context, File file) =>
      AutoRouter.of(context).push(TestRoute(file: file));
}
