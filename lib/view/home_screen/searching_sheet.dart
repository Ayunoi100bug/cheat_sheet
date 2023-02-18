import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

import '../../data/network/pdf_api.dart';
import '../../res/button.dart';
import '../../res/components/sheet.dart';
import '../../utils/routes/routes.gr.dart';
import '../../view_model/file_passer.dart';

class SearchingSheet extends StatefulWidget {
  const SearchingSheet({super.key});

  @override
  State<SearchingSheet> createState() => _SearchingSheetState();
}

class _SearchingSheetState extends State<SearchingSheet> {
  int selectedItem = 0;
  // late PDFViewController controller;
  // int numberPages = 0;
  // int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.008, vertical: screenWidth * 0.048),
                  child: const Regular20px(text: "กรุณาเลือกชีทเพื่อเป็นหน้าปกและตัวอย่างชีท"),
                ),
                PrimaryButton(
                    text: 'นำเข้าชีท',
                    onPressed: () async {
                      final file = await PDFApi.pickFile(context);
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
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          GestureDetector(
                            child: Container(
                              color: selectedItem == index ? Colors.amber : Colors.green,
                            ),
                            onTap: () {
                              setState(() {
                                selectedItem = index;
                                print("$selectedItem");
                              });
                            },
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Radio(
                                value: index,
                                groupValue: selectedItem,
                                onChanged: (value) {
                                  setState(() {
                                    selectedItem = value as int;
                                  });
                                }),
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
