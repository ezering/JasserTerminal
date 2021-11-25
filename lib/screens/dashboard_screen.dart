// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acceuil'),
      ),
      body: Center(
        child: Text('Ecran de demarrage', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
