import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:auto_route/auto_route.dart';
import '../res/button.dart';
import '../res/colors.dart';
import '../res/components/custom_appbar.dart';
import '../res/components/tag.dart';
import '../res/typo.dart';

class AboutGrade extends StatefulWidget {
  const AboutGrade({super.key});

  @override
  State<AboutGrade> createState() => _AboutGradeState();
}

class _AboutGradeState extends State<AboutGrade> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomAppBar.appBarColor,
        title: CustomAppBar.textLogo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: isPortrait ? screenWidth * 0.08 : screenWidth * 0.04),
          child: Column(
            children: [
              const Medium16px(text: "โปรดเลือกระดับชั้นศึกษา"),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Tag(
                          subject: "ประฐมศึกษาตอนต้น",
                          onPressed: () {
                            AutoRouter.of(context).push(AboutSubjectRoute(grade: 'ประฐมศึกษาตอนต้น'));
                          },
                        ),
                        Tag(
                          subject: "ประฐมศึกษาตอนปลาย",
                          onPressed: () {
                            AutoRouter.of(context).push(AboutSubjectRoute(grade: 'ประฐมศึกษาตอนปลาย'));
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Tag(
                          subject: "มัธยมศึกษาตอนต้น",
                          onPressed: () {
                            AutoRouter.of(context).push(AboutSubjectRoute(grade: 'มัธยมศึกษาตอนต้น'));
                          },
                        ),
                        Tag(
                          subject: "มัธยมศึกษาตอนปลาย",
                          onPressed: () {
                            AutoRouter.of(context).push(AboutSubjectRoute(grade: 'มัธยมศึกษาตอนปลาย'));
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: isPortrait ? screenWidth * 0.05 : screenWidth * 0.16),
                      child: Tag(
                        subject: "มหาวิทยาลัย",
                        onPressed: () {
                          AutoRouter.of(context).push(AboutSubjectRoute(grade: 'มหาวิทยาลัย'));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: isPortrait ? screenWidth * 1.12 : screenWidth * 0.02,
              ),
              OutlineButton(
                text: 'ข้าม',
                color: AppColors.tertiary500,
                onPressed: () {
                  AutoRouter.of(context).push(HomeScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
