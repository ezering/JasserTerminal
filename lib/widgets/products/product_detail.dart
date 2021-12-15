import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              // height: 350,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    const CircleAvatar(
                      child: Text("Numéro Produit / Image"),
                      radius: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Titre du Produit",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Prix : ",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  "15.00€",
                                  style: Theme.of(context).textTheme.bodyText1,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Quantité : ",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  "2l",
                                  style: Theme.of(context).textTheme.bodyText1,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Produit ID : ",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  "sfef-hgrt-dsez",
                                  style: Theme.of(context).textTheme.bodyText1,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                      Icons.mode_edit_outline_outlined),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete_outlined),
                                  color: Theme.of(context).errorColor,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.post_add_rounded),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.print_outlined),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Description",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    "\nContient l'alcool, déconseillé pour les bébés, conseiller dans un cadre sociale....blah blah blah!.",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
