// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jasser_terminal/screens/shop/shop_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Acceuil'),
        ),
        body: const ShopScreen());
  }
}
