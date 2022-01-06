import 'package:flutter/material.dart';
import 'package:jasser_terminal/widgets/products/add_form_product.dart';

class QuickAddProductScreen extends StatelessWidget {
  static const routeName = '/add-product-quick';
  const QuickAddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addProductAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            WelcomeTextAddProduct(),
            AddProductFormWithShelfId(),
          ],
        ),
      ),
    );
  }

  AppBar addProductAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Ajouter un produit',
          style: TextStyle(color: Colors.purple)),
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.purple),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    );
  }
}

class WelcomeTextAddProduct extends StatelessWidget {
  const WelcomeTextAddProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: const Text(
        'Ajouter un produit!',
        style: TextStyle(
          color: Colors.purple,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
