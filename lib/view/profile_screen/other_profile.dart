import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../res/button.dart';
import '../../res/colors.dart';
import '../../res/components/sheet.dart';
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
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: screenWidth < 480
                    ? screenHeight * 0.24
                    : screenHeight * 0.48,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      children: <Widget>[
                        SizedBox(
                          width: constraints.maxWidth * 0.4,
                          height: double.infinity,
                          child: Padding(
                            padding:
                                EdgeInsets.all(constraints.maxHeight * 0.12),
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
                              height: constraints.maxHeight * 0.4,
                              width: constraints.maxWidth * 0.6,
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
                              height: constraints.maxHeight * 0.3,
                              width: constraints.maxWidth * 0.6,
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
                            PrimaryButton(
                              text: "ติดตาม",
                              onPressed: () {},
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              const Divider(thickness: 1, height: 1),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.032),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isPortrait ? 3 : 5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    mainAxisExtent: isPortrait ? 200 : 250,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Sheet(
                      sheetTitle: Image.asset('assets/images/logo.png'),
                      title: 'สถิติพื้นฐานooooooooooo',
                      priceSheet: 10,
                      username: 'Macaronnnnnnnnnnnnnnnnnnnnnn',
                      sheetId: index + 1,
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
