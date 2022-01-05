import 'package:flutter/material.dart';
import 'package:jasser_terminal/widgets/shop/edit_shop_form.dart';

class EditShopScreen extends StatelessWidget {
  static const routeName = '/edit-shop';
  const EditShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: editShopAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            WelcomeTextEditShop(),
            EditShopForm(),
          ],
        ),
      ),
    );
  }

  AppBar editShopAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Editer une boutique',
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

class WelcomeTextEditShop extends StatelessWidget {
  const WelcomeTextEditShop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: const Text(
        'Editer votre boutique!',
        style: TextStyle(
          color: Colors.purple,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
