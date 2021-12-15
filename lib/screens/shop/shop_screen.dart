import 'package:flutter/material.dart';
import 'package:jasser_terminal/screens/shelf/shelf_screen.dart';
import 'package:jasser_terminal/widgets/swipe/delete_swipe.dart';
import 'package:jasser_terminal/widgets/swipe/edit_swipe.dart';

class ShopScreen extends StatelessWidget {
  static const routeName = '/shop';
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(10),
      children: [
        Dismissible(
          key: const ValueKey('1'),
          background: const EditSwipe(),
          secondaryBackground: const DeleteSwipe(),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              final bool res = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text(
                          "Etes-vous sûr que vous voulez supprimer?"),
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
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ShelfScreen.routeName);
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
                    "Boutique #1",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Tournai - Belgique",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),

        Dismissible(
          key: const ValueKey('1'),
          background: const EditSwipe(),
          secondaryBackground: const DeleteSwipe(),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              final bool res = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text(
                          "Etes-vous sûr que vous voulez supprimer?"),
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
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ShelfScreen.routeName);
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
                    "Boutique #2",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Mouscron - Belgique",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),

        // Pour ajouter une boutique supplementaire
        InkWell(
          onTap: () {},
          splashColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_business_rounded, size: 50),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(height: 10),
                    Text("Ajouter Une Boutique",
                        style: Theme.of(context).textTheme.headline6),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 4 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
