import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Tag extends StatelessWidget {
  final String subject;
  final IconData? icon;
  const Tag({
    super.key,
    required this.subject,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: TagButton(
        height: isPortrait ? screenHeight * 0.03 : screenHeight * 0.015,
        width: isPortrait ? screenHeight * 0.01 : screenHeight * 0.015,
        text: subject,
        size: isPortrait ? 10 : 15,
        icon: icon,
        onPressed: () {},
        textcolor: AppColors.orange600,
        color: AppColors.orange100,
      ),
    );
  }
}
