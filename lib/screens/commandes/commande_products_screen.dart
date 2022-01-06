import 'package:flutter/material.dart';
import 'package:jasser_terminal/widgets/drawer/custom_drawer.dart';
import 'package:jasser_terminal/widgets/commandes/commande_product.dart';

class CommandeProductList extends StatelessWidget {
  static const routeName = '/category-product-list';

  const CommandeProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits Dans la catégorie'),
      ),
      body: const CommandeProducts(),
      drawer: const CustomDrawer(),
    );
  }
}
