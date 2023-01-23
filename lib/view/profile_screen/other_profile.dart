import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';
import '../../res/gap_dimension.dart';
import '../../res/typo.dart';
import '../../utils/routes/routes.gr.dart';

class OtherProfile extends StatefulWidget {
  const OtherProfile({super.key});

  @override
  State<OtherProfile> createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: screenWidth < 480
                    ? screenHeight * GapDimension.h0_18
                    : screenHeight * GapDimension.h0_36,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      children: <Widget>[
                        Container(
                          width: constraints.maxWidth * GapDimension.w0_4,
                          height: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(
                                constraints.maxHeight * GapDimension.h0_12),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/logo.png'),
                                  // fit: BoxFit.fill,
                                ),
                                border: Border.all(
                                    color: AppColors.black800, width: 2.0),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: constraints.maxHeight * GapDimension.h0_5,
                              width: constraints.maxWidth * GapDimension.w0_6,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Medium24px(text: "Book"),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      AutoRouter.of(context).push(
                                          EditProfileRoute(userId: "userId"));
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * GapDimension.h0_5,
                              width: constraints.maxWidth * GapDimension.w0_6,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Medium20px(text: "eiei"),
                                      const Regular14px(text: "ผู้ติดตาม"),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Medium20px(text: "bibi"),
                                      const Regular14px(text: "กำลังติตดาม"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
