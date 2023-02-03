import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../res/gap_dimension.dart';

import '../../res/components/review.dart';

class SheetListScreen extends StatefulWidget {
  const SheetListScreen({super.key});

  @override
  State<SheetListScreen> createState() => _SheetListScreenState();
}

class _SheetListScreenState extends State<SheetListScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: screenWidth * 0.032, right: screenWidth * 0.032),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.tertiary500),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            FontAwesomeIcons.add,
                            color: AppColors.tertiary500,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        )),
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 300,
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Regular16px(
                                    text: 'ชีทลิสต์ใหม่',
                                  ),
                                  Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.black400),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const TextField(
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'ชื่อชีทลิสต์',
                                      ),
                                    ),
                                  ),
                                  PrimaryButton(
                                    text: 'บันทึก',
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * GapDimension.w0_032),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: screenWidth < 480
                          ? MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.1)
                          : MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 0.4),
                    ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return Container(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Column(
                              children: [
                                Container(
                                  height: constraints.maxHeight * 0.8,
                                  color: AppColors.black300,
                                ),
                                Container(
                                  height: constraints.maxHeight * 0.2,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            height: constraints.maxHeight * 0.5,
                                            child: Regular12px(
                                                text: 'ชีทที่ถูกใจ'),
                                          ),
                                          Container(
                                            height: constraints.maxHeight * 0.5,
                                            child: Regular12px(text: '20 ชีท'),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
