import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';
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
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: <Widget>[
            InkWell(
              child: Text('text form'),
              onTap: () {
                AutoRouter.of(context).push(CreateDetailSheetRoute());
              },
            ),
            SizedBox(
              width: screenWidth,
              height: screenWidth < 420
                  ? constraints.maxHeight * 0.5
                  : constraints.maxHeight * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    FontAwesomeIcons.download,
                    size: screenWidth < 480
                        ? screenHeight * 0.1
                        : screenHeight * 0.2,
                    color: AppColors.black400,
                  ),
                  SizedBox(
                    height: screenHeight * 0.008,
                  ),
                  PrimaryButton(text: 'นำเข้าชีท', onPressed: () {}),
                ],
              ),
            ),
            Container(
              height: screenWidth < 420
                  ? constraints.maxHeight * 0.5
                  : constraints.maxHeight * 0.4,
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.032),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlineButton(text: 'ยกเลิก', onPressed: () {}),
                    PrimaryButton(
                      text: 'ตกลง',
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
