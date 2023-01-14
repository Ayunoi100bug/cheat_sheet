import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view/profile_page/my_sheet.dart';
import 'package:cheat_sheet/view/profile_page/buy_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                    Container(
                      width: double.infinity,
                      height: screenWidth < 480
                          ? screenHeight * 0.18
                          : screenHeight * 0.36,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Row(
                            children: <Widget>[
                              Container(
                                width: constraints.maxWidth * 0.4,
                                height: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      constraints.maxHeight * 0.12),
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
                                    height: constraints.maxHeight * 0.5,
                                    width: constraints.maxWidth * 0.6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const Medium24px(text: "BookyZ"),
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.5,
                                    width: constraints.maxWidth * 0.6,
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

        // SingleChildScrollView(
        //   child: Container(
        //     height: MediaQuery.of(context).size.height,
        //     child: Column(
        //       children: <Widget>[
        //         Container(
        //           width: double.infinity,
        //           height: screenWidth < 480
        //               ? screenHeight * 0.18
        //               : screenHeight * 0.36,
        //           child: LayoutBuilder(
        //             builder: (context, constraints) {
        //               return Row(
        //                 children: <Widget>[
        //                   Container(
        //                     width: constraints.maxWidth * 0.4,
        //                     height: double.infinity,
        //                     child: Padding(
        //                       padding:
        //                           EdgeInsets.all(constraints.maxHeight * 0.12),
        //                       child: Container(
        //                         decoration: BoxDecoration(
        //                           image: const DecorationImage(
        //                             image: NetworkImage(
        //                                 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Red_Apple.jpg/800px-Red_Apple.jpg'),
        //                             // fit: BoxFit.fill,
        //                           ),
        //                           border: Border.all(
        //                               color: AppColors.black800, width: 2.0),
        //                           shape: BoxShape.circle,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Column(
        //                     children: <Widget>[
        //                       SizedBox(
        //                         height: constraints.maxHeight * 0.5,
        //                         width: constraints.maxWidth * 0.6,
        //                         child: Row(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: <Widget>[
        //                             const Medium24px(text: "BookyZ"),
        //                             IconButton(
        //                               icon: Icon(Icons.edit),
        //                               onPressed: () {},
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                       SizedBox(
        //                         height: constraints.maxHeight * 0.5,
        //                         width: constraints.maxWidth * 0.6,
        //                         child: Row(
        //                           mainAxisAlignment:
        //                               MainAxisAlignment.spaceEvenly,
        //                           children: [
        //                             Column(
        //                               children: const [
        //                                 Medium20px(text: "120"),
        //                                 Regular14px(text: "ผู้ติดตาม"),
        //                               ],
        //                             ),
        //                             Column(
        //                               children: const [
        //                                 Medium20px(text: "120"),
        //                                 Regular14px(text: "กำลังติตดาม"),
        //                               ],
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ],
        //               );
        //             },
        //           ),
        //         ),
        //         Container(
        //           height: screenWidth < 480
        //               ? screenHeight * 0.82
        //               : screenHeight * 0.64,
        //           child: Column(
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(5),
        //                 child: TabBar(
        //                   controller: tabController,
        //                   labelStyle: const TextStyle(
        //                     fontSize: 16,
        //                     fontFamily: 'BaiJamjuree',
        //                     fontWeight: FontWeight.w500,
        //                   ),
        //                   labelColor: AppColors.primary700,
        //                   indicatorWeight: 1,
        //                   indicatorColor: AppColors.primary700,
        //                   unselectedLabelColor: AppColors.black400,
        //                   tabs: const [
        //                     Tab(
        //                       text: 'ชีทของฉัน',
        //                     ),
        //                     Tab(
        //                       text: 'ชีทที่ซื้อ',
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               Expanded(
        //                 child: TabBarView(
        //                   controller: tabController,
        //                   children: const [
        //                     MySheet(),
        //                     BuySheet(),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

// class TabButton extends StatelessWidget {
//   final String? text;
//   final int selectedPage;
//   final int pageNumber;
//   final VoidCallback onPressed;
//   const TabButton({
//     super.key,
//     this.text,
//     required this.selectedPage,
//     required this.pageNumber,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         decoration: BoxDecoration(
//           color: selectedPage == pageNumber ? Colors.blue : Colors.transparent,
//           borderRadius: BorderRadius.circular(4),
//         ),
//         padding: EdgeInsets.symmetric(
//           horizontal: 20,
//           vertical: 12,
//         ),
//         child: Text(
//           "${text}",
//           style: TextStyle(
//             color: selectedPage == pageNumber ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
