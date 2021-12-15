import 'package:flutter/material.dart';
import 'package:jasser_terminal/screens/category/category_screen.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category-screen';

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catégories'),
      ),
      body: const CategoryScreenList(),
    );
  }
}
