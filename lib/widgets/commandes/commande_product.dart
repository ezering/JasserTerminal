import 'package:flutter/material.dart';
import 'commande_list_items.dart';

class CommandeProducts extends StatelessWidget {
  static const routeName = '/commande-products';
  const CommandeProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return CommandesListItems(index: index);
      },
      itemCount: 10,
    );
  }
}
