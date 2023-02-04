import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../res/components/custom_appbar.dart';

class TopUp extends StatefulWidget {
  const TopUp({super.key});

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AutoLeadingButton(),
        backgroundColor: CustomAppBar.appBarColor,
      ),
      body: Text('This is top up page'),
    );
  }
}
