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

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
      padding: EdgeInsets.all(screenWidth * GapDimension.w0_032),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isPortrait ? 3 : 5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 12,
          mainAxisExtent: isPortrait ? 200 : 250,
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
