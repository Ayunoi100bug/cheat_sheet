import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateSheetScreen extends StatefulWidget {
  const CreateSheetScreen({super.key});

  @override
  State<CreateSheetScreen> createState() => _CreateSheetScreenState();
}

class _CreateSheetScreenState extends State<CreateSheetScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height:
                  screenWidth < 480 ? screenHeight * 0.3 : screenHeight * 0.1,
            ),
            Icon(
              FontAwesomeIcons.download,
              size: screenWidth < 480 ? screenHeight * 0.1 : screenHeight * 0.2,
              color: AppColors.black400,
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            ElevatedButton(
                child: Regular16px(
                  text: "นำเข้าชีท",
                  color: AppColors.white,
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.only(
                        left: screenWidth < 480
                            ? screenWidth * 0.1
                            : screenWidth * 0.05,
                        right: screenWidth < 480
                            ? screenWidth * 0.1
                            : screenWidth * 0.05)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.tertiary500),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: AppColors.tertiary500)))),
                onPressed: () => null),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                        onPressed: () {},
                        child: Regular16px(
                          text: 'ยกเลิก',
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.only(
                                left: screenWidth < 480
                                    ? screenWidth * 0.1
                                    : screenWidth * 0.05,
                                right: screenWidth < 480
                                    ? screenWidth * 0.1
                                    : screenWidth * 0.05)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: AppColors.black700)))),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Regular16px(
                          text: 'ตกลง',
                          color: AppColors.white,
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.only(
                                left: screenWidth < 480
                                    ? screenWidth * 0.1
                                    : screenWidth * 0.05,
                                right: screenWidth < 480
                                    ? screenWidth * 0.1
                                    : screenWidth * 0.05)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.tertiary500),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: AppColors.tertiary500)))),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
