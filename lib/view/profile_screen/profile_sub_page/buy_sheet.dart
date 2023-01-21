import 'package:cheat_sheet/res/gap_dimension.dart';
import 'package:flutter/material.dart';

import '../../../res/components/sheet.dart';

class BuySheet extends StatelessWidget {
  const BuySheet({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

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
        itemCount: 12,
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
