import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/commande.dart';
import 'package:jasser_terminal/widgets/drawer/custom_drawer.dart';
import 'package:jasser_terminal/widgets/commandes/commande_product.dart';

class CommandeProductList extends StatelessWidget {
  static const routeName = '/commande-product-list';

  const CommandeProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commandeList =
        ModalRoute.of(context)!.settings.arguments as List<Commande>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits Dans la commande'),
      ),
      body:  CommandeProducts(commandes: commandeList),
      drawer: const CustomDrawer(),
    );
  }
}
