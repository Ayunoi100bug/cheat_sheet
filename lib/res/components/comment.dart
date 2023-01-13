import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Comment extends StatefulWidget {
  const Comment({super.key});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      //width: double.infinity,
      //height: 120,
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(10),
          //color: AppColors.black400,
          ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Regular12px(text: "name"),
                      Row(
                        children: [
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.thumb_up_alt_outlined),
                  Text("100"),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
          Regular12px(text: "comment"),
          SizedBox(height: 4),
          Regular12px(text: "date"),
        ],
      ),
    );
  }
}
