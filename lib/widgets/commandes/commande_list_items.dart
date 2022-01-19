import 'package:flutter/material.dart';
import 'package:jasser_terminal/screens/product/product_detail_screen.dart';
import 'package:jasser_terminal/widgets/swipe/delete_swipe.dart';
import 'package:jasser_terminal/widgets/swipe/edit_swipe.dart';

class CommandesListItems extends StatelessWidget {
  const CommandesListItems({
    required this.index,
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(index.toString()),
      background: const EditSwipe(),
      secondaryBackground: const DeleteSwipe(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          final bool res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content:
                      const Text("Etes-vous sûr que vous voulez supprimer?"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        "Annuler",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text(
                        "Supprimer",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
          return res;
        } else {
          // Allez Sur la page Editer;
        }
      },
      child: Card(
        child: ListTile(
          onTap: () {
            // Allez Sur la page Details;
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName);
          },
          visualDensity: VisualDensity.comfortable,
          leading: CircleAvatar(
            child: Text('${index + 1}'),
            radius: 20,
          ),
          title: const Text('Titre - Produit'),
          subtitle: const Text('Déscription'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Icon(Icons.print_outlined),
              SizedBox(width: 10),
              Icon(Icons.post_add_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
