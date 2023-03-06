import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view_model/file_passer.dart';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:provider/provider.dart';
import '../../res/components/flushbar.dart';

class PickDemoPages extends StatefulWidget {
  final PdfDocument doc;
  final int pagesNumber;
  const PickDemoPages({super.key, required this.doc, required this.pagesNumber});

  @override
  State<PickDemoPages> createState() => _PickDemoPagesState();
}

class _PickDemoPagesState extends State<PickDemoPages> {
  late int _count;
  List<int> _selectedItems = [];
  late List<bool> _checks;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _count = widget.pagesNumber;
    _checks = List.generate(_count, (_) => false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AutoRouter.of(context).push(CreateDetailSheetRoute(demoPages: _selectedItems));
        },
        backgroundColor: AppColors.tertiary500,
        child: const Icon(Icons.arrow_forward_ios_rounded),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.008, vertical: screenWidth * 0.048),
                  child: const Regular20px(text: "กรุณาเลือกหน้าชีทตัวอย่าง"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isPortrait ? 2 : 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 16,
                      mainAxisExtent: isPortrait ? 250 : 300,
                    ),
                    itemCount: _count,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          PdfPageView(pdfDocument: widget.doc, pageNumber: index + 1),
                          Align(
                            alignment: Alignment.topRight,
                            child: Checkbox(
                              value: _checks[index],
                              onChanged: (newvalue) {},
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              color: _checks[index] ? Colors.transparent : Colors.transparent,
                            ),
                            onTap: () {
                              setState(() {
                                if (_checks.where((check) => check).length >= 5 && !_checks[index]) {
                                  FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, "เลือกได้สูงสุด 5 หน้า");
                                  return;
                                }
                                _checks[index] = !_checks[index];
                                int pageNumber = index + 1;
                                if (_selectedItems.contains(pageNumber)) {
                                  _selectedItems.remove(pageNumber);
                                } else {
                                  _selectedItems.add(pageNumber);
                                }
                                _selectedItems.sort();
                              });
                            },
                          ),
                        ],
                      );
                    },
                    padding: EdgeInsets.only(bottom: screenWidth * 0.048),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
