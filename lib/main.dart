import 'package:flutter/material.dart';
import '/screens/splash_screen.dart';
import 'screens/auth/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jasser Terminal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'QuickSand',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
