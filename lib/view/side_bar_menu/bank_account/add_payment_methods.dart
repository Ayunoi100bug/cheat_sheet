import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';

class AddPaymentMethods extends StatefulWidget {
  const AddPaymentMethods({super.key});

  @override
  State<AddPaymentMethods> createState() => _AddPaymentMethodsState();
}

class _AddPaymentMethodsState extends State<AddPaymentMethods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('นี่คือหน้าเพิ่มวิธีการชำระเงิน'),
              ElevatedButton(
                  onPressed: () {
                    AutoRouter.of(context).push(AddCardRoute());
                  },
                  child: Text('ไปหน้าเพิ่มบัตร'))
            ],
          ),
        ),
      ),
    );
  }
}
