import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';

class Sheet extends StatefulWidget {
  const Sheet({super.key});

  @override
  State<Sheet> createState() => _SheetState();
}

class _SheetState extends State<Sheet> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              color: AppColors.black300,
              height: constraints.maxHeight*0.7,
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                InkWell(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://icons.veryicon.com/png/o/internet--web/55-common-web-icons/person-4.png',
                    ),
                    radius: constraints.maxHeight*0.061,
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Regular12px(text: 'สถิติพื้นฐานooooooooooo'),
                      Regular10px(text: 'Macaron1111111111111'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Medium12px(
                  text: 'FREE',
                  color: AppColors.primary600,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                    ),
                    Light12px(text: '4.5'),
                  ],
                ),
              ],
            ),
          ],
        );
      }
    );
  }
}
