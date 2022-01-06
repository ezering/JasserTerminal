import 'package:flutter/material.dart';
import 'package:jasser_terminal/widgets/products/edit_product_form.dart';

class EditProductScreen extends StatelessWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: editProductAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            WelcomeTextEditProduct(),
            EditProductForm(),
          ],
        ),
      ),
    );
  }

  AppBar editProductAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Editer un produit',
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

class WelcomeTextEditProduct extends StatelessWidget {
  const WelcomeTextEditProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: const Text(
        'Editer un produit!',
        style: TextStyle(
          color: Colors.purple,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
