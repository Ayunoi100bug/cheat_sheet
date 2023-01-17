import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../utils/routes/routes.gr.dart';
import 'custom_appbar.dart';

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
            child: InkWell(
              onTap: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: constraints.maxHeight * 0.02,
            ),
            height: constraints.maxHeight * 0.3,
            child: LayoutBuilder(builder: (context, constraints) {
              return SizedBox(
                child: Column(
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.7,
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Row(
                          children: [
                            InkWell(
                              child: Container(
                                width: constraints.maxWidth * 0.25,
                                child: CircleAvatar(
                                  backgroundImage: sheetTitle.image,
                                ),
                              ),
                              onTap: () {
                                print("click to profile");
                              },
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.05,
                            ),
                            Container(
                              width: constraints.maxWidth * 0.7,
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                return Column(
                                  children: [
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        height: constraints.maxHeight * 0.5,
                                        child: Regular12px(
                                            text: title,
                                            activateOverflow: true)),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        height: constraints.maxHeight * 0.5,
                                        child: Regular10px(
                                            text: username,
                                            activateOverflow: true)),
                                  ],
                                );
                              }),
                            ),
                          ],
                        );
                      }),
                    ),
                    Container(
                      height: constraints.maxHeight * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              if (priceSheet == 0) Medium12px(text: 'FREE'),
                              if (priceSheet > 0) CustomAppBar.coin,
                              if (priceSheet > 0)
                                Regular12px(
                                  text: priceSheet.toString(),
                                  color: AppColors.orange700,
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: constraints.maxHeight * 0.25,
                              ),
                              Light12px(text: '4.5'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      );
    });
  }
}
