import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../utils/routes/routes.gr.dart';
import 'custom_appbar.dart';

class Sheet extends StatelessWidget {
  final String authorImage;
  final String title;
  final String username;
  final int priceSheet;
  final int sheetId;
  const Sheet(
      {super.key,
      required this.authorImage,
      required this.title,
      required this.username,
      required this.priceSheet,
      required this.sheetId});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Card(
      elevation: 4,
      shadowColor: AppColors.black900,
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      AutoRouter.of(context)
                        .navigateNamed('/home/' + sheetId.toString());
                    },
                    child: CachedNetworkImage(
                      imageUrl: 'https://i.pinimg.com/originals/3d/83/e4/3d83e4284ba67ebcc3ca74c179ad5c1d.jpg',
                      fit: BoxFit.fill,
                      width: constraints.maxWidth,
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.35,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Column(
                      children: [
                        SizedBox(
                          height: constraints.maxHeight * 0.65,
                          width: constraints.maxWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: constraints.maxWidth * 0.025,
                                    right: constraints.maxWidth * 0.025),
                                alignment: Alignment.center,
                                height: isPortrait
                                    ? constraints.maxHeight * 0.45
                                    : constraints.maxHeight * 0.4,
                                width: constraints.maxWidth * 0.3,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: CachedNetworkImageProvider(authorImage),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: constraints.maxWidth * 0.025,
                                  right: constraints.maxWidth * 0.025,
                                ),
                                height: constraints.maxHeight * 0.7,
                                width: constraints.maxWidth * 0.7,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * 0.5,
                                        width: constraints.maxWidth,
                                        alignment: Alignment.bottomCenter,
                                        child: Regular14px(
                                          text: title,
                                          activateOverflow: true,
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * 0.5,
                                        width: constraints.maxWidth,
                                        alignment: Alignment.topCenter,
                                        child: Regular12px(
                                          text: username,
                                          activateOverflow: true,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: constraints.maxWidth * 0.025,
                            right: constraints.maxWidth * 0.025,
                          ),
                          height: constraints.maxHeight * 0.35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  if (priceSheet == 0) Medium12px(text: 'FREE'),
                                  if (priceSheet > 0) CustomAppBar.coin,
                                  if (priceSheet > 0)
                                    Regular12px(
                                      text: priceSheet.toString(),
                                      color: AppColors.orange700,
                                    ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: constraints.maxHeight * 0.25,
                                  ),
                                  Light12px(text: '4.5'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
