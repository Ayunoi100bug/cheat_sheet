import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/view_model/payment.dart';
import 'package:flutter/material.dart';

import '../../res/components/custom_appbar.dart';
import '../../res/typo.dart';

class TopUp extends StatefulWidget {
  const TopUp({super.key});

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: const Regular20px(
          text: 'เติมเงิน',
          color: AppColors.white,
        ),
        backgroundColor: CustomAppBar.appBarColor,
      ),
      body: GridView.count(
        padding: const EdgeInsets.only(top: 48, left: 36, right: 36, bottom: 12),
        crossAxisSpacing: isPortrait ? 40 : 50,
        mainAxisSpacing: isPortrait ? 40 : 45,
        crossAxisCount: isPortrait ? 2 : 4,
        children: <Widget>[
          _TopUpCoin(context, '70 เหรียญ', 'assets/images/coin.png', '35 บาท', 70, 35),
          _TopUpCoin(context, '210 เหรียญ', 'assets/images/coins2.png', '105 บาท', 210, 105),
          _TopUpCoin(context, '558 เหรียญ', 'assets/images/coins3.png', '279 บาท', 558, 279),
          _TopUpCoin(context, '1158 เหรียญ', 'assets/images/coins4.png', '579 บาท', 1158, 579),
          _TopUpCoin(context, '1598 เหรียญ', 'assets/images/coins5.png', '799 บาท', 1598, 799),
          _TopUpCoin(context, '2048 เหรียญ', 'assets/images/coins6.png', '1024 บาท', 2048, 1024),
        ],
      ),
    );
  }
}

Widget _TopUpCoin(context, coin, image, money, int coinAmount, int price) {
  double screenWidth = MediaQuery.of(context).size.width;
  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  return InkWell(
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.tertiary600.withOpacity(0.7)),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Regular14px(text: coin, color: AppColors.white),
          SizedBox(height: isPortrait ? screenWidth * 0.032 : screenWidth * 0.020),
          Image.asset(
            image,
            height: 56,
          ),
          SizedBox(height: isPortrait ? screenWidth * 0.032 : screenWidth * 0.024),
          Medium20px(
            text: money,
            color: AppColors.error500,
          ),
        ],
      ),
    ),
    onTap: () async {
      await PaymentApi().stripePayment(context, coinAmount, price);
    },
  );
}
