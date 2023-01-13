import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/components/bottom_bar.dart';
import 'package:cheat_sheet/utils/routes/routes.dart';
import 'package:cheat_sheet/utils/routes/routes_name.dart';
import 'package:cheat_sheet/view/activity_screen.dart';
import 'package:cheat_sheet/view/home/main_screen.dart';
import 'package:cheat_sheet/view/home_screen.dart';
import 'package:cheat_sheet/view/login.dart';
import 'package:cheat_sheet/view/register.dart';
import 'package:cheat_sheet/view_model/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
    // );
  }
}
