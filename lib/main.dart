import 'dart:io';

import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/utils/stripe_key.dart';
import 'package:cheat_sheet/view_model/color_passer.dart';
import 'package:cheat_sheet/view_model/file_passer.dart';
import 'package:cheat_sheet/view_model/file_passer_for_read.dart';
import 'package:cheat_sheet/view_model/question_image_passer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final FirebaseFirestore _db = FirebaseFirestore.instance;
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();
    // messaging.getToken().then((value) {
    //   print(value);
    // });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("message recieved");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text(message.notification?.title ?? "ccxc"),
            subtitle: Text(message.notification?.body ?? ""),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });

    if (Platform.isIOS) {
      var iosSubscription = FirebaseMessaging.instance.onTokenRefresh.listen((data) {
        _saveDeviceToken();
      });
      FirebaseMessaging.instance.requestPermission();
    } else {
      _saveDeviceToken();
    }
  }

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
        routerDelegate: widget._appRouter.delegate(),
        routeInformationParser: widget._appRouter.defaultRouteParser(),
      ),
    );
  }

  _saveDeviceToken() async {
    // Get the current user
    final _auth = FirebaseAuth.instance;
    // Get the token for this device
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).collection('tokens').doc(fcmToken);

      await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }
}
