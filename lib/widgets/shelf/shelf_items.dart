import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/shelf.dart';
import 'package:jasser_terminal/providers/shelfs.dart';
import 'package:jasser_terminal/screens/shelf/edit_shelf_screen.dart';
import 'package:jasser_terminal/screens/shelf/shelf_products_screen.dart';
import 'package:jasser_terminal/widgets/swipe/delete_swipe.dart';
import 'package:jasser_terminal/widgets/swipe/edit_swipe.dart';
import 'package:provider/provider.dart';

class ShelfItemDismissable extends StatelessWidget {
  const ShelfItemDismissable({
    Key? key,
    required this.shelfData,
    required this.shopId,
  }) : super(key: key);
  final String shopId;

  final Shelf shelfData;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(shelfData.id),
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
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child: const Text(
                        "Supprimer",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Provider.of<Shelfs>(context, listen: false)
                            .deleteShelf(shelfData.id);
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                );
              });
          return res;
        } else {
          // Allez Sur la page Editer;
          Navigator.of(context)
              .pushNamed(EditShelfScreen.routeName, arguments: shelfData.id);
        }
      },
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(ShelfProducts.routeName,
              arguments: {'shopId': shopId, 'shelfId': shelfData.id});
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
                shelfData.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 3),
              Text(
                shelfData.description,
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
