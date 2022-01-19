import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/commande.dart';
import 'package:jasser_terminal/models/shop.dart';
import 'package:jasser_terminal/providers/commandes.dart';
import 'package:jasser_terminal/screens/commandes/commande_products_screen.dart';
import 'package:jasser_terminal/widgets/swipe/delete_swipe.dart';
import 'package:jasser_terminal/widgets/swipe/print_swipe.dart';
import 'package:provider/provider.dart';

class CommandeShopItemDismissable extends StatelessWidget {
  const CommandeShopItemDismissable({
    Key? key,
    required this.shopCommande,
    required this.commandes,
  }) : super(key: key);

  final Shop shopCommande;
  final List<Commande> commandes;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(shopCommande.id),
      background: const PrintSwipe(),
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
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child: const Text(
                        "Supprimer",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Provider.of<Commandes>(context, listen: false)
                            .deleteCommandes(commandes)
                            .then((value) => Navigator.of(context).pop(true));
                      },
                    ),
                  ],
                );
              });
          return res;
        } else {
          // Allez vers l'impression px etr;
          //
        }
      },
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(CommandeProductList.routeName, arguments: commandes);
        },
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Commandes: ${shopCommande.name}",
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 3),
              Text(
                "${commandes.length.toString()} produit(s) sur la liste.",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).secondaryHeaderColor,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
