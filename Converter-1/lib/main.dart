import 'package:curren_see/screens/history.dart';
import 'package:curren_see/screens/converter.dart';
import 'package:curren_see/screens/login.dart';
import 'package:curren_see/screens/ratelist.dart';
import 'package:curren_see/screens/register.dart';
import 'package:curren_see/screens/Home2.dart';
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
      home: ScreenProduct(),
    );
  }
}
