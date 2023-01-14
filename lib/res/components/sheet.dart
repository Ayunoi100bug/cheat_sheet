import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';

class Sheet extends StatelessWidget {
  final Image sheetTitle;
  final String title;
  final String username;
  final int priceSheet;
  const Sheet({
    super.key,
    required this.sheetTitle,
    required this.title,
    required this.username,
    required this.priceSheet,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
            color: AppColors.black300,
            height: constraints.maxHeight * 0.7,
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            children: [
              InkWell(
                child: CircleAvatar(
                  backgroundImage: sheetTitle.image,
                  radius: constraints.maxHeight * 0.061,
                ),
                onTap: () {},
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Regular12px(text: title),
                    Regular10px(text: username),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Medium12px(
                text: priceSheet == 0 ? 'FREE' : priceSheet.toString(),
                color: AppColors.primary600,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 16,
                  ),
                  Light12px(text: '4.5'),
                ],
              ),
            ],
          ),
        ],
      );
    });
  }
}
