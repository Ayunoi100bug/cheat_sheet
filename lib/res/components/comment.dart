import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Comment extends StatefulWidget {
  const Comment({super.key});

  // final Image userImage;
  // final String userName;
  // final int userStart;
  // final Text comment;
  // final DateTime dateTime;
  // final int thumbLike;

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.black300),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://icons.veryicon.com/png/o/internet--web/55-common-web-icons/person-4.png%27'),
                      radius: 16,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Regular14px(text: "Name"),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                            ),
                            Icon(
                              Icons.star,
                              size: 16,
                            ),
                            Icon(
                              Icons.star,
                              size: 16,
                            ),
                            Icon(
                              Icons.star,
                              size: 16,
                            ),
                            Icon(Icons.star, size: 16),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    //ใช้ในการกดต้องมาทำเพิ่ม
                    Icon(Icons.thumb_up_outlined),
                    SizedBox(width: screenWidth * 0.02),
                    Regular14px(text: "100"),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              color: AppColors.error200,
              //constraints: BoxConstraints(maxWidth: constraints.maxWidth),
              child: Regular14px(
                  text:
                      "Commenttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt"),
            ),
            SizedBox(height: screenHeight * 0.01),
            Regular14px(text: "Date"),
            Divider(
              color: AppColors.black500,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
