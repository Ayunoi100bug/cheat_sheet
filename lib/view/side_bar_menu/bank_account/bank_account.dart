import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view/side_bar_menu/bank_account/add_payment_methods.dart';
import 'package:flutter/material.dart';

class BankAccount extends StatefulWidget {
  const BankAccount({super.key});

  @override
  State<BankAccount> createState() => _BankAccountState();
}

class _BankAccountState extends State<BankAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('นี่คือหน้าข้อมูลบัญชีธนาคาร'),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(AddPaymentMethodsRoute());
                },
                child: Text('ไปหน้าเพิ่มวิธีการชำระเงิน'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
