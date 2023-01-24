import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/pdf_openner.dart';
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
                        Regular16px(
                          text: 'เพิ่มชีทลิสต์',
                          color: AppColors.tertiary500,
                        ),
                        Icon(
                          FontAwesomeIcons.add,
                          color: AppColors.tertiary500,
                        ),
                      ],
                    ),
                    onTap: () async {
                      final url =
                          'https://www.africau.edu/images/default/sample.pdf';
                      final file = await PDFApi.loadNetwork(url);
                      // final file = await PDFApi.pickFile();
                      if (file == null) return;
                      PDFOpenner.openPDF(context, file);
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
