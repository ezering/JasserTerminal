import 'package:flutter/material.dart';

import 'commandes/commande_screen.dart';

class CommandeScreen extends StatelessWidget {
  static const routeName = '/commande-screen';

  const CommandeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commandes'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: const [
          CommandeScreenList(),
        ],
      )),
    );
  }
}
