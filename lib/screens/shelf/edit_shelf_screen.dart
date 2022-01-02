import 'package:flutter/material.dart';
import 'package:jasser_terminal/screens/shelf/shelf_screen.dart';
import 'package:jasser_terminal/widgets/shop/add_shop_form.dart';

class EditShelfScreen extends StatelessWidget {
  static const routeName = '/edit-shelf';
  const EditShelfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: editShelfAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            WelcomeTextEditShelf(),
            AddShopForm(),
          ],
        ),
      ),
    );
  }

  AppBar editShelfAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Editer une étagère',
          style: TextStyle(color: Colors.purple)),
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.purple),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                ShelfScreen.routeName, (route) => false);
          }),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    );
  }
}

class WelcomeTextEditShelf extends StatelessWidget {
  const WelcomeTextEditShelf({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: const Text(
        'Editer une étagère!',
        style: TextStyle(
          color: Colors.purple,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}