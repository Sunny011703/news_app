import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/src/AnimatedBottomNavigationBar.dart';


void main() {
   HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
     home: AnimatedBottomNavigationBar(),
    );
  }
}
