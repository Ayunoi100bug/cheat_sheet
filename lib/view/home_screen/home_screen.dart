import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view/home_screen/detail_sheet.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';
import '../../res/typo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  AutoRouter.of(context).push(DetailSheetRoute());
                },
                child: Text('Press Here'),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8)),
              SizedBox(
                width: double.infinity,
                height: 35,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppColors.secondary800,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: AppColors.secondary800,
                      ),
                      Light20px(
                        text: 'Search',
                        color: AppColors.primary600,
                      )
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8)),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 16,
                ).copyWith(right: 0),
                child: Row(
                  children: [
                    Medium20px(text: 'ชีทแนะนำสำหรับคุณ'),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8)),
              GridView.builder(
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
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Sheet();
                },
                padding: EdgeInsets.only(bottom: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
