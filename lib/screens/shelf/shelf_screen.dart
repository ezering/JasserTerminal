import 'package:flutter/material.dart';
import 'package:jasser_terminal/widgets/drawer/custom_drawer.dart';
import 'package:jasser_terminal/widgets/shelf/shelf_list.dart';

class ShelfScreen extends StatelessWidget {
  static const routeName = '/shelf';
  const ShelfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etagère'),
      ),
      body: const ShelfList(),
      drawer: const CustomDrawer(),
    );
  }
}
