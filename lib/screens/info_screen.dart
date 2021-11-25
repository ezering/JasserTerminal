// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
      ),
      body: Center(
        child: Text('Information Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
