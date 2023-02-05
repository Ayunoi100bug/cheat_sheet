import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../button.dart';

Widget Popup_CreateTag(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    title: Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: screenHeight * 0.016),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.black800),
            borderRadius: BorderRadius.circular(50),
          ),
          child: TextFormField(
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'เพิ่ม/ค้นหาแท็ก',
              suffixIcon: InkWell(
                child: Icon(Icons.add),
                onTap: () => print("add tag"),
              ),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.012,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Medium16px(text: 'แท็กที่เลือก'),
        ),
        SizedBox(
          height: screenHeight * 0.08,
        ),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlineButton(text: 'ยกเลิก', onPressed: () {}),
          PrimaryButton(
            text: 'เพิ่มแท็ก',
            onPressed: () {},
          ),
        ],
      ),
    ],
  );
}
