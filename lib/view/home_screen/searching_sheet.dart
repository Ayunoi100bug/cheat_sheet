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
  late File file;
  late PDFViewController controller;
  int numberPages = 0;
  int currentPage = 0;
  int selectedItem = 0;
  static const int _count = 10;
  final List<bool> _checks = List.generate(_count, (_) => false);
  final List<int> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary500,
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
                PrimaryButton(
                    text: 'นำเข้าชีท',
                    onPressed: () async {
                      file = (await PDFApi.pickFile(context))!;
                      if (file == null) return;
                    }),
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
                          GestureDetector(
                            child: Container(
                              color: _checks[index] ? Colors.black : Colors.grey,
                            ),
                            onTap: () {
                              setState(() {
                                if (_checks.where((check) => check).length >= 5 && !_checks[index]) {
                                  FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, "เลือกได้สูงสุด 5 หน้า");
                                  return;
                                }
                                _checks[index] = !_checks[index];
                                if (_selectedItems.contains(index)) {
                                  _selectedItems.remove(index);
                                } else {
                                  _selectedItems.add(index);
                                }
                              });
                            },
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Checkbox(
                              value: _checks[index],
                              onChanged: (newValue) {
                                setState(() {
                                  if (_checks.where((check) => check).length >= 5 && !_checks[index]) {
                                    return;
                                  }
                                  _checks[index] = !_checks[index];
                                  if (_selectedItems.contains(index)) {
                                    _selectedItems.remove(index);
                                  } else {
                                    _selectedItems.add(index);
                                  }
                                });
                              },
                            ),
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
