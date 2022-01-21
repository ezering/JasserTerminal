import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/commande.dart';
import 'package:jasser_terminal/models/printer.dart';
import 'package:jasser_terminal/models/product.dart';
import 'package:jasser_terminal/providers/commandes.dart';
import 'package:jasser_terminal/providers/products.dart';
import 'package:jasser_terminal/screens/product/edit_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    Key? key,
    required this.singleProductData,
    required this.shelfId,
    required this.shopId,
  }) : super(key: key);
  final Product singleProductData;
  final String shelfId;
  final String shopId;
  @override
  Widget build(BuildContext context) {
    final commandeProvider = Provider.of<Commandes>(context, listen: true);
    Commande _commandeToAdd;
    Commande? _commandeToRemove;

    bool _isCommandeExist(Commande _commandeToAdd) {
      for (var commande in commandeProvider.commandes) {
        if (commande.product.id == _commandeToAdd.product.id) {
          return true;
        }
      }
      return false;
    }

    bool _isProductExistInCommande(String id) {
      return commandeProvider.commandes
          .any((commande) => commande.product.id == id);
    }

    Commande? _findCommande(String id) {
      for (var commande in commandeProvider.commandes) {
        if (commande.product.id == id) {
          return commande;
        }
      }
      return null;
    }

    String _qrCodeData(String id, String shelfId, String shopId) {
      return json.encode({
        'id': id,
        'shelfId': shelfId,
        'shopId': shopId,
      });
    }

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
                    Container(
                      color: Colors.white,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: QrImage(
                          data: _qrCodeData(
                              singleProductData.id, shelfId, shopId),
                          version: QrVersions.auto,
                          size: 200,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      singleProductData.name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // Edit, Delete, add to list and print Buttons
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      shadowColor: Colors.black,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      elevation: 30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        EditProductScreen.routeName,
                                        arguments: {
                                          'productId': singleProductData.id,
                                          'shelfId': shelfId
                                        });
                                  },
                                  icon: const Icon(
                                      Icons.mode_edit_outline_outlined),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Provider.of<Products>(context,
                                            listen: false)
                                        .deleteProduct(singleProductData.id);
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.delete_outlined),
                                  color: Theme.of(context).errorColor,
                                ),

                                ///  Add to product to commande List
                                _isProductExistInCommande(singleProductData.id)
                                    ? IconButton(
                                        onPressed: () {
                                          _commandeToRemove = _findCommande(
                                              singleProductData.id);

                                          if (_isProductExistInCommande(
                                              singleProductData.id)) {
                                            commandeProvider
                                                .deleteCommande(
                                                    _commandeToRemove)
                                                .then(
                                              (value) {
                                                ScaffoldMessenger.of(context)
                                                    .removeCurrentSnackBar();
                                                return ScaffoldMessenger.of(
                                                        context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration:
                                                        Duration(seconds: 1),
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                      'Produit supprimer de la liste des commandes',
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                duration: Duration(seconds: 1),
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                    'Produit n\'est pas dans la liste des commandes'),
                                              ),
                                            );
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.check_circle_outline,
                                          color: Colors.green,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          _commandeToAdd = Commande(
                                            id: DateTime.now().toString(),
                                            shopId: shopId,
                                            shelfId: shelfId,
                                            product: singleProductData,
                                          );
                                          if (!_isCommandeExist(
                                              _commandeToAdd)) {
                                            commandeProvider
                                                .addCommande(_commandeToAdd)
                                                .then(
                                              (value) {
                                                ScaffoldMessenger.of(context)
                                                    .removeCurrentSnackBar();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration:
                                                        Duration(seconds: 1),
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                      'Produit ajouté à la liste des commandes',
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }

                                          if (commandeProvider.commandes
                                              .contains(_commandeToAdd)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                duration: Duration(seconds: 1),
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                    'Produit déjà dans la liste des commandes'),
                                              ),
                                            );
                                          }
                                        },
                                        icon:
                                            const Icon(Icons.post_add_rounded),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                IconButton(
                                  onPressed: () {
                                    Printer.printProduct(
                                        context,
                                        singleProductData,
                                        _qrCodeData(singleProductData.id,
                                            shelfId, shopId));
                                  },
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
                                  "${singleProductData.price}€",
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
                                  singleProductData.quantity,
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
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    singleProductData.id,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
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
                                    singleProductData.description,
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

class ShortcutButtonsForProduct extends StatelessWidget {
  const ShortcutButtonsForProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      shadowColor: Colors.black,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      elevation: 30,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mode_edit_outline_outlined),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outlined),
                  color: Theme.of(context).errorColor,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.post_add_rounded),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.print_outlined),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
