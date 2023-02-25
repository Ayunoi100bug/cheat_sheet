import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../res/button.dart';
import '../../../res/colors.dart';
import '../../../res/components/custom_appbar.dart';
import '../../../res/components/popup_ccv.dart';
import '../../../res/typo.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        leading: AutoLeadingButton(),
        title: Regular20px(
          text: 'เพิ่มบัตรการชำระเงิน',
          color: AppColors.white,
        ),
        backgroundColor: CustomAppBar.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: isPortrait ? screenWidth * 0.08 : screenWidth * 0.04, bottom: isPortrait ? 0 : screenWidth * 0.04),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Medium20px(text: 'บัตรเดบิต หรือบัตรเครดิต'),
              ),
              SizedBox(
                height: isPortrait ? screenWidth * 0.08 : screenWidth * 0.012,
              ),
              CardFormField(
                autofocus: true,
                controller: CardFormEditController(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: isPortrait ? screenWidth * 0.74 : screenWidth * 0.02, left: isPortrait ? screenWidth * 0.6 : screenWidth * 0.58),
                child: PrimaryButton(
                  text: 'เสร็จ',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
