import 'package:cheat_sheet/res/components/bottom_bar.dart';
import 'package:cheat_sheet/utils/routes/routes.dart';
import 'package:cheat_sheet/utils/routes/routes_name.dart';
import 'package:cheat_sheet/view/activity_screen.dart';
import 'package:cheat_sheet/view/home/main_screen.dart';
import 'package:cheat_sheet/view/home_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //home: mainScreenLogin(),
      initialRoute: routesName.main,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
