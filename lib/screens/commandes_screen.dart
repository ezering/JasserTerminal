import 'package:flutter/material.dart';

import 'commandes/commande_screen.dart';

class CommandeScreen extends StatelessWidget {
  static const routeName = '/category-screen';

  const CommandeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catégories'),
      ),
      body: const CommandeScreenList(),
    );
  }
}
