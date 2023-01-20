import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateDetailSheet extends StatefulWidget {
  const CreateDetailSheet({super.key});

  @override
  State<CreateDetailSheet> createState() => _CreateDetailSheetState();
}

enum SheetType { free, sell }

class _CreateDetailSheetState extends State<CreateDetailSheet> {
  SheetType? _sheetType = SheetType.free;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(
                  isPortrait ? screenHeight * 0.024 : screenHeight * 0.048),
              height: isPortrait ? screenHeight * 0.35 : screenHeight * 0.6,
              child: Image(
                image: NetworkImage(
                    'https://static.trueplookpanya.com/tppy/member/m_665000_667500/665461/cms/images/%E0%B9%84%E0%B8%AD%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%88%E0%B8%94%E0%B8%8A%E0%B8%B5%E0%B8%97%E0%B8%AA%E0%B8%A3%E0%B8%B8%E0%B8%9B_15.jpg'),
              ),
            ),
            Container(
                margin:
                    EdgeInsets.only(left: isPortrait ? 0 : screenWidth * 0.2),
                padding: EdgeInsets.only(
                    left: screenHeight * 0.024,
                    top:
                        isPortrait ? screenHeight * 0.04 : screenHeight * 0.08),
                alignment: Alignment.centerLeft,
                child: const Medium16px(text: 'ชื่อ')),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: isPortrait ? screenWidth : screenWidth * 0.3,
                padding: EdgeInsets.all(
                    isPortrait ? screenHeight * 0.002 : screenHeight * 0.004),
                margin: EdgeInsets.only(
                    left: isPortrait ? screenHeight * 0.024 : screenWidth * 0.2,
                    right: isPortrait
                        ? screenHeight * 0.024
                        : screenHeight * 0.048),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: 'ชื่อ',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(screenHeight * 0.008))),
              ),
            ),
            Container(
                width: isPortrait ? screenWidth : screenWidth * 0.6,
                padding: EdgeInsets.only(
                    left: screenHeight * 0.024, top: screenHeight * 0.02),
                alignment: Alignment.centerLeft,
                child: const Medium16px(text: 'รายละเอียด')),
            Container(
              width: isPortrait ? screenWidth : screenWidth * 0.6,
              height: isPortrait ? screenHeight * 0.15 : screenHeight * 0.25,
              padding: EdgeInsets.all(screenHeight * 0.002),
              margin: EdgeInsets.only(
                  left: screenHeight * 0.024, right: screenHeight * 0.024),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                maxLines: null,
                scrollPadding: const EdgeInsets.all(20.0),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'รายละเอียด',
                    hintStyle: const TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.all(screenHeight * 0.008)),
              ),
            ),
            Container(
                margin:
                    EdgeInsets.only(left: isPortrait ? 0 : screenWidth * 0.2),
                padding: EdgeInsets.only(
                    left: screenHeight * 0.024,
                    top:
                        isPortrait ? screenHeight * 0.02 : screenHeight * 0.04),
                alignment: Alignment.centerLeft,
                child: const Medium16px(text: 'แท็ก')),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: isPortrait
                            ? screenHeight * 0.024
                            : screenWidth * 0.2,
                        top: screenHeight * 0.01),
                    width: isPortrait ? screenWidth * 0.2 : screenWidth * 0.1,
                    height:
                        isPortrait ? screenHeight * 0.05 : screenHeight * 0.1,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(30),
                      child: const Align(
                          alignment: Alignment.center,
                          child: Icon(FontAwesomeIcons.add)),
                      dashPattern: [10, 10],
                    ),
                  ),
                ),
              ],
            ),
            Container(
                margin:
                    EdgeInsets.only(left: isPortrait ? 0 : screenWidth * 0.2),
                padding: EdgeInsets.only(
                    left: screenHeight * 0.024, top: screenHeight * 0.02),
                alignment: Alignment.centerLeft,
                child: const Medium16px(text: 'ประเภทของชีท')),
            Container(
              margin: EdgeInsets.only(left: isPortrait ? 0 : screenWidth * 0.2),
              child: Column(
                children: [
                  ListTile(
                    title: const Medium16px(text: 'ฟรี'),
                    leading: Radio<SheetType>(
                      value: SheetType.free,
                      groupValue: _sheetType,
                      onChanged: (SheetType? value) {
                        setState(() {
                          _sheetType = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Medium16px(text: 'ขาย'),
                    leading: Radio<SheetType>(
                      value: SheetType.sell,
                      groupValue: _sheetType,
                      onChanged: (SheetType? value) {
                        setState(() {
                          _sheetType = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (_sheetType == SheetType.sell)
              Container(
                  margin:
                      EdgeInsets.only(left: isPortrait ? 0 : screenWidth * 0.2),
                  padding: EdgeInsets.only(
                      left: screenHeight * 0.024, bottom: screenHeight * 0.01),
                  alignment: Alignment.centerLeft,
                  child: const Medium16px(text: 'ราคา')),
            if (_sheetType == SheetType.sell)
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(screenHeight * 0.002),
                  margin: EdgeInsets.only(
                      left:
                          isPortrait ? screenHeight * 0.024 : screenWidth * 0.2,
                      right: screenHeight * 0.024),
                  width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.125,
                  height:
                      isPortrait ? screenHeight * 0.04 : screenHeight * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'หน่วย coin',
                        hintStyle: const TextStyle(fontSize: 12),
                        contentPadding: EdgeInsets.all(isPortrait
                            ? screenHeight * 0.016
                            : screenHeight * 0.032)),
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: isPortrait ? 0 : screenWidth * 0.2,
                      top: isPortrait ? 0 : screenHeight * 0.04),
                  padding: EdgeInsets.all(screenHeight * 0.024),
                  child: OutlineButton(
                    text: 'ยกเลิก',
                    onPressed: () {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      right: isPortrait ? 0 : screenWidth * 0.2,
                      top: isPortrait ? 0 : screenHeight * 0.04),
                  padding: EdgeInsets.all(screenHeight * 0.024),
                  child: PrimaryButton(
                    text: 'เสร็จสิ้น',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
