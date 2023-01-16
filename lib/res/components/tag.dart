import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Tag extends StatelessWidget {
  final String subject;
  const Tag({
    super.key,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: PrimaryButton(
        height: screenHeight * 0.03,
        width: screenWidth * 0.01,
        text: subject,
        size: 10,
        onPressed: () {},
        textcolor: AppColors.orange600,
        color: AppColors.orange100,
      ),
    );
  }
}
