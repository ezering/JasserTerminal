// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
      ),
      body: Center(
        child: Text('Scan Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
