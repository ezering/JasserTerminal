import 'package:flutter/material.dart';
import 'package:jasser_terminal/widgets/drawer/custom_drawer.dart';
import 'package:jasser_terminal/widgets/products/shelf_products.dart';

class ShelfProducts extends StatelessWidget {
  static const routeName = '/shelf-products';
  const ShelfProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits sur étagère'),
      ),
      body: const ShelfProductsList(),
      drawer: const CustomDrawer(),
    );
  }
}
