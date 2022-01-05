import 'package:flutter/material.dart';
import 'package:jasser_terminal/widgets/shop/add_shop_form.dart';

class AddShopScreen extends StatelessWidget {
  static const routeName = '/add-shop';
  const AddShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addShopAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            WelcomeTextAddShop(),
            AddShopForm(),
          ],
        ),
      ),
    );
  }

  AppBar addShopAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Ajouter une boutique',
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

class WelcomeTextAddShop extends StatelessWidget {
  const WelcomeTextAddShop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: const Text(
        'Ajouter une boutique!',
        style: TextStyle(
          color: Colors.purple,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
