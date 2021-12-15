import 'package:flutter/material.dart';
import 'package:jasser_terminal/widgets/drawer/custom_drawer.dart';
import 'package:jasser_terminal/widgets/products/category_product.dart';

class CategoryProductList extends StatelessWidget {
  static const routeName = '/category-product-list';

  const CategoryProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits Dans la catégorie'),
      ),
      body: const CategoryProducts(),
      drawer: const CustomDrawer(),
    );
  }
}
