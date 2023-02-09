import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../res/button.dart';
import '../../../res/colors.dart';
import '../../../res/components/custom_appbar.dart';
import '../../../res/components/popup_ccv.dart';
import '../../../res/typo.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        leading: AutoLeadingButton(),
        title: Regular20px(
          text: 'เพิ่มบัตรการชำระเงิน',
          color: AppColors.white,
        ),
        backgroundColor: CustomAppBar.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: isPortrait ? screenWidth * 0.08 : screenWidth * 0.04,
              bottom: isPortrait ? 0 : screenWidth * 0.04),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Medium20px(text: 'บัตรเดบิต หรือบัตรเครดิต'),
              ),
              SizedBox(
                height: isPortrait ? screenWidth * 0.04 : screenWidth * 0.012,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left:
                        isPortrait ? screenWidth * 0.088 : screenWidth * 0.06),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Regular16px(text: 'ข้อมูลบัตร'),
                      SizedBox(
                        height: isPortrait
                            ? screenWidth * 0.04
                            : screenWidth * 0.024,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: screenWidth * 0.016),
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black800),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'หมายเลขบัตร',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: isPortrait
                            ? screenWidth * 0.04
                            : screenWidth * 0.024,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: screenWidth * 0.016),
                            width: screenWidth * 0.4,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.black800),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'วันหมดอายุ(ดด/ปป)',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: isPortrait
                                ? screenWidth * 0.09
                                : screenWidth * 0.1,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: screenWidth * 0.016),
                            width: screenWidth * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.black800),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'CCV',
                                suffixIcon: InkWell(
                                  child: Icon(
                                    Icons.question_mark,
                                    color: AppColors.black400,
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          Popup_CCV(context),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: isPortrait
                            ? screenWidth * 0.04
                            : screenWidth * 0.024,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: screenWidth * 0.016),
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black800),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'ชื่อเจ้าของบัตร',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: isPortrait ? screenWidth * 0.9 : screenWidth * 0.02,
                    left: isPortrait ? screenWidth * 0.6 : screenWidth * 0.58),
                child: PrimaryButton(
                  text: 'เสร็จ',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
