import 'package:flutter/material.dart';
import 'package:jasser_terminal/widgets/drawer/custom_drawer.dart';
import 'package:jasser_terminal/widgets/products/product_detail.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du produit'),
      ),
      body: const ProductDetails(),
      drawer: const CustomDrawer(),
    );
  }
}
