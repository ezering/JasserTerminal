// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category-screen';

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Center(
        child: Text('Categories Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
 