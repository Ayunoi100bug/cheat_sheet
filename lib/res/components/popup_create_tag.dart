import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../button.dart';

Widget Popup_CreateTag(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    title: Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: screenHeight * 0.016),
          child: TextField(
            //controller: _searchController,
            cursorColor: AppColors.black900,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              fillColor: AppColors.black200,
              filled: true,
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(width: 1, color: AppColors.primary800)),
              hintText: 'เพิ่ม/ค้นหาแท็ก',
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(width: 1, color: AppColors.primary800)),
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
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
