import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view/side_bar_menu/bank_account/add_payment_methods.dart';
import 'package:flutter/material.dart';

import '../../../res/colors.dart';
import '../../../res/components/custom_appbar.dart';
import '../../../res/typo.dart';

class BankAccount extends StatefulWidget {
  const BankAccount({super.key});

  @override
  State<BankAccount> createState() => _BankAccountState();
}

class _BankAccountState extends State<BankAccount> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        leading: AutoLeadingButton(),
        title: Regular20px(
          text: 'ข้อมูลบัญชีธนาคาร',
          color: AppColors.white,
        ),
        backgroundColor: CustomAppBar.appBarColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [_mastercard(context)],
              ),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: screenWidth * 0.04,
                      top: isPortrait
                          ? screenWidth * 0.03
                          : screenWidth * 0.024),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.black300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.12,
                          right: screenWidth * 0.12,
                          top: screenWidth * 0.024,
                          bottom: screenWidth * 0.024),
                      child: Regular16px(
                        text: '+ เพิ่มวิธีการชำระเงิน',
                        color: AppColors.secondary500,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  AutoRouter.of(context).push(AddPaymentMethodsRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _mastercard(context) {
  double screenWidth = MediaQuery.of(context).size.width;
  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  return Padding(
    padding: EdgeInsets.only(
        top: screenWidth * 0.04,
        left: isPortrait ? screenWidth * 0.016 : screenWidth * 0.16,
        right: isPortrait ? screenWidth * 0.016 : screenWidth * 0.16,
        bottom: isPortrait ? screenWidth * 0.04 : screenWidth * 0.008),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.black300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: isPortrait ? screenWidth * 0.04 : screenWidth * 0.044,
            right: isPortrait ? screenWidth * 0.12 : screenWidth * 0.044,
            top: screenWidth * 0.04,
            bottom: screenWidth * 0.04),
        child: Row(
          children: [
            Image.asset(
              'assets/images/mastercard.png',
              width: isPortrait ? 92 : 100,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: isPortrait ? screenWidth * 0.2 : screenWidth * 0.24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Regular16px(text: 'Mastercard **** 1234'),
                  Regular12px(
                    text: 'หมดอายุ 01/23',
                    color: AppColors.black400,
                  ),
                  SizedBox(
                    height:
                        isPortrait ? screenWidth * 0.04 : screenWidth * 0.044,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width:
                            isPortrait ? screenWidth * 0.3 : screenWidth * 0.14,
                      ),
                      InkWell(
                        child: Regular12px(
                          text: 'แก้ไข',
                          color: AppColors.tertiary500,
                          underline: true,
                        ),
                        onTap: () {
                          print('edit');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
