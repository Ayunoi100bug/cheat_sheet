import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    super.key,
  });

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      color: AppColors.black400,
      height: isPortrait ? screenHeight * 0.22 : screenHeight * 0.44,
      child: ListView.builder(
          padding: EdgeInsets.only(left: 12, right: 12, top: 12),
          scrollDirection: Axis.horizontal,
          itemExtent: MediaQuery.of(context).size.width * 0.28,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Card(
                  color: AppColors.white,
                  child: Image.network(
                    "https://static.trueplookpanya.com/tppy/member/m_665000_667500/665461/cms/images/%E0%B9%84%E0%B8%AD%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%88%E0%B8%94%E0%B8%8A%E0%B8%B5%E0%B8%97%E0%B8%AA%E0%B8%A3%E0%B8%B8%E0%B8%9B_04.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Regular16px(text: "${index + 1}"),
              ],
            );
          }),
    );
  }
}
