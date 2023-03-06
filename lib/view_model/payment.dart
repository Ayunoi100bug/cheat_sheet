import 'dart:convert';

import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/view_model/update_firestore.dart';
import 'package:cheat_sheet/view_model/auth.dart';
import 'package:cheat_sheet/res/components/popup_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:cheat_sheet/utils/stripe_key.dart';

class PaymentApi {
  final _stripe = Stripe.instance;
  Map<String, dynamic>? paymentIntentData;

  Future<void> stripePayment(BuildContext context, int coinAmount, int price) async {
    if (!AuthService().isLogged()) {
      showDialog(
        context: context,
        builder: (BuildContext context) => Popup_Login(context),
      );
      return;
    }
    try {
      paymentIntentData = await createPaymentIntent(price.toString(), "THB");
      await _stripe.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        style: ThemeMode.system,
        merchantDisplayName: "CheatSheet",
      ));
      if (context.mounted) {
        displayPaymentSheet(context, coinAmount);
      }
    } catch (e) {
      debugPrint("Exception: ${e.toString()}");
    }
  }

  displayPaymentSheet(BuildContext context, int coinAmount) async {
    try {
      await _stripe.presentPaymentSheet();
      if (context.mounted) {
        await UpdateCollection().userTopup(context, coinAmount);
      }
    } on StripeException catch (e) {
      debugPrint(e.toString());
      String message = 'การทำรายการถูกยกเลิก';
      FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, message);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'), body: body, headers: {
        'Authorization': 'Bearer $stripeSecretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      });
      return jsonDecode(response.body.toString());
    } catch (e) {
      debugPrint("Exception: ${e.toString()}");
    }
  }

  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }
}
