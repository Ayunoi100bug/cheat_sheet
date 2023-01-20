import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/gap_dimension.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view/profile_screen/profile_sub_page/my_sheet.dart';
import 'package:cheat_sheet/view/profile_screen/profile_sub_page/buy_sheet.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            scrollDirection: Axis.vertical,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: screenWidth < 480
                          ? screenHeight * GapDimension.h0_18
                          : screenHeight * GapDimension.h0_36,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Row(
                            children: <Widget>[
                              SizedBox(
                                width: constraints.maxWidth * GapDimension.w0_4,
                                height: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      constraints.maxHeight *
                                          GapDimension.h0_12),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Red_Apple.jpg/800px-Red_Apple.jpg'),
                                        // fit: BoxFit.fill,
                                      ),
                                      border: Border.all(
                                          color: AppColors.black800,
                                          width: 2.0),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: constraints.maxHeight *
                                        GapDimension.h0_5,
                                    width: constraints.maxWidth *
                                        GapDimension.w0_6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const Medium24px(text: "BookyZ"),
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight *
                                        GapDimension.h0_5,
                                    width: constraints.maxWidth *
                                        GapDimension.w0_6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: const [
                                            Medium20px(text: "120"),
                                            Regular14px(text: "ผู้ติดตาม"),
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Medium20px(text: "120"),
                                            Regular14px(text: "กำลังติตดาม"),
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
                    TabBar(
                      controller: tabController,
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'BaiJamjuree',
                        fontWeight: FontWeight.w500,
                      ),
                      labelColor: AppColors.primary700,
                      indicatorWeight: 1,
                      indicatorColor: AppColors.primary700,
                      unselectedLabelColor: AppColors.black400,
                      tabs: const [
                        Tab(
                          text: 'ชีทของฉัน',
                        ),
                        Tab(
                          text: 'ชีทที่ซื้อ',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            body: TabBarView(
              controller: tabController,
              children: const [
                MySheet(),
                BuySheet(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
