import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';

import '../../../res/colors.dart';
import '../../../res/components/custom_appbar.dart';
import '../../../res/typo.dart';

class AddPaymentMethods extends StatefulWidget {
  const AddPaymentMethods({super.key});

  @override
  State<AddPaymentMethods> createState() => _AddPaymentMethodsState();
}

class _AddPaymentMethodsState extends State<AddPaymentMethods> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        leading: AutoLeadingButton(),
        title: Regular20px(
          text: 'เพิ่มวิธีการชำระเงิน',
          color: AppColors.white,
        ),
        backgroundColor: CustomAppBar.appBarColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              top: isPortrait ? screenWidth * 0.08 : screenWidth * 0.036,
              left: screenWidth * 0.044),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Medium16px(text: 'บัตรเดบิต หรือเครดิต'),
              InkWell(
                child: Image.asset(
                  'assets/images/visa.png',
                  height: isPortrait ? 100 : 120,
                ),
                onTap: () {
                  AutoRouter.of(context).push(AddCardRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
