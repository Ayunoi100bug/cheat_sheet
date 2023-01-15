import 'package:cheat_sheet/res/colors.dart';
import 'package:flutter/material.dart';

import '../../res/components/sheet.dart';
import '../../res/gap_dimension.dart';
import '../../res/typo.dart';

class MySheet extends StatelessWidget {
  const MySheet({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth * GapDimension.w0_032),
      child: GridView.builder(
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
        itemCount: 8,
        itemBuilder: (context, index) {
          return Sheet(
            sheetTitle: Image.asset('assets/images/logo.png'),
            title: 'สถิติพื้นฐานooooooooooo',
            priceSheet: 0,
            username: 'Macaronnnnnnnnnnnnnnnnnnnnnn',
          );
          ;
        },
      ),
    );
  }
}
