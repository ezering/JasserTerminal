import 'package:flutter/material.dart';
import 'package:jasser_terminal/screens/shelf/add_shelf_screen.dart';

class AddShelfButton extends StatelessWidget {
  const AddShelfButton({Key? key, required this.shopId}) : super(key: key);
  final String shopId;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(AddShelfScreen.routeName, arguments: shopId);
        },
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              AddShelfScreen.routeName,
                              arguments: shopId);
                        },
                        icon: const Icon(Icons.add_circle_outline_outlined,
                            size: 25),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Text("Ajouter Une étagère",
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).secondaryHeaderColor,
                    Theme.of(context).colorScheme.primary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
