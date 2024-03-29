import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/utils/stripe_key.dart';
import 'package:cheat_sheet/view_model/color_passer.dart';
import 'package:cheat_sheet/view_model/file_passer.dart';
import 'package:cheat_sheet/view_model/file_passer_for_read.dart';
import 'package:cheat_sheet/view_model/question_image_passer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return FilePasser();
        }),
        ChangeNotifierProvider(create: (context) {
          return FilePasserForRead();
        }),
        ChangeNotifierProvider(create: (context) {
          return QuestionImagePasser();
        }),
        ChangeNotifierProvider(create: (context) {
          return ColorPasser();
        }),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'CheatSheet',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
    // );
  }
}
