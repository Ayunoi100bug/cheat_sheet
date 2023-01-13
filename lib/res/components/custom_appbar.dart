//รูปแบบ App Bar ทั้ง 4 แบบ


//AppBarNotLogin
// appbar: AppBar(
//       backgroundColor: CustomAppBar.appBarColor,
//       title: CustomAppBar.textLogo,
//     ),
//     endDrawer: SidebarMenu(),


// AppBarBackNotLogin
// appbar: AppBar(
//       backgroundColor: CustomAppBar.appBarColor,
//       leading: CustomAppBar.arrowBack,
//     ),
//     endDrawer: SidebarMenu(),


// AppBarLogin
//ใส่ไว้ก่อนเริ่มคลาส state
//final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

// key: _scaffoldKey,
// appbar: AppBar(
//   backgroundColor: CustomAppBar.appBarColor,
//   title: CustomAppBar.textLogo,
//     actions: [
//       CustomAppBar.coin,
//       CustomAppBar.notifications,
//       IconButton(
//         icon: Icon(Icons.menu, size:24),
//         onPressed: () {
//           _scaffoldKey.currentState!.openEndDrawer();
//         },
//       ),
//     ],
// ),


// AppBarBackLogin
//ใส่ไว้ก่อนเริ่มคลาส state
//final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

// key: _scaffoldKey,
// appbar: AppBar(
//   backgroundColor: CustomAppBar.appBarColor,
//   leading: CustomAppBar.arrowBack,
//     actions: [
//       CustomAppBar.coin,
//       CustomAppBar.notifications,
//       IconButton(
//         icon: Icon(Icons.menu, size:24),
//         onPressed: () {
//           _scaffoldKey.currentState!.openEndDrawer();
//         },
//       ),
//     ],
// )

import 'package:another_flushbar/flushbar.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  static Color appBarColor = AppColors.primary600;

  static Text textLogo = Text("CHEETSHEET");

  static Image coinImage = Image.asset('assets/images/star.png', width: 22, height: 22,);
  
  static InkWell coin = InkWell( onTap: () {}, child: coinImage,);
  
  static IconButton notifications = IconButton(onPressed: (){}, icon: Icon(Icons.notifications, size: 24,));

  static IconButton arrowBack = IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new_outlined, size: 24,));
}
