import 'package:flutter/material.dart';
import 'package:jasser_terminal/widgets/shelf/add_shelf_form.dart';

class AddShelfScreen extends StatelessWidget {
  static const routeName = '/add-shelf';
  const AddShelfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shopId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: addShelfAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children:  <Widget>[
            const WelcomeTextAddShelf(),
            AddShelfForm(shopId: shopId),
          ],
        ),
      ),
    );
  }

  AppBar addShelfAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Ajouter une étagère',
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

class WelcomeTextAddShelf extends StatelessWidget {
  const WelcomeTextAddShelf({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: const Text(
        'Ajouter une étagère!',
        style: TextStyle(
          color: Colors.purple,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
