import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/components/popup.dart';
import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view/home_screen/detail_sheet.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';
import '../../res/gap_dimension.dart';
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

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * GapDimension.w0_032),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  AutoRouter.of(context).push(TestUIRoute());
                },
                child: Text('กด ตรงนี้ นะ บุ๊คคค'),
              ),
              PrimaryButton(
                  text: "Top snackBar",
                  onPressed: () => Popup.showSnackBar(
                      context,
                      false,
                      Icon(
                        Icons.celebration_outlined,
                        color: AppColors.white,
                      ),
                      'ความสำเร็จเสร็จสิ้น "เช็คอินครบ 5 วัน"')),
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
