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
      child: LayoutBuilder(builder: (context, constraints) {
        return ListView.builder(
            padding: EdgeInsets.only(
                left: constraints.maxWidth * 0.02,
                right: constraints.maxWidth * 0.02,
                top: constraints.maxWidth * 0.02),
            scrollDirection: Axis.horizontal,
            itemExtent: MediaQuery.of(context).size.width * 0.28,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
                    color: AppColors.white,
                    child: Image.network(
                      "https://image.dek-d.com/27/0675/4232/124870565",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Regular16px(text: "${index + 1}"),
                ],
              );
            });
      }),
    );
  }
}
