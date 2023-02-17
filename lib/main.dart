import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtuard/screens/bottomnavbar.dart';
import 'package:virtuard/screens/home.dart';

enum NetworkStatus { online, offline }

void main() async {
  var connectedornot = NetworkStatus.offline;
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      connectedornot = NetworkStatus.online;
    } else {
      connectedornot = NetworkStatus.offline;
    }
  } on SocketException catch (_) {
    connectedornot = NetworkStatus.offline;
  }
  runApp(MyApp(connectedornot: connectedornot));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.connectedornot});
  final connectedornot;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xfff0e5069),
        statusBarBrightness: Brightness.light,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Virtuard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        backgroundColor: Colors.black,
        duration: 3000,
        splashIconSize: 180,
        splash: "assets/images/logo.png",
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: BottomNavBar(
          connectedornot: connectedornot,
        ),
      ),
    );
  }
}
