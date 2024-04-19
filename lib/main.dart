import 'package:flutter/material.dart';
import 'package:flutter_application_1/hikerscreen.dart';
import 'package:flutter_application_1/screens/getstarted.dart';

void main() {
  runApp(HikersApp());
}

class HikersApp extends StatelessWidget {
  const HikersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetStartedScreen(),
    );
  }
}
