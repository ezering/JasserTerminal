import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/commande.dart';
import 'package:jasser_terminal/models/printer.dart';
import 'package:jasser_terminal/providers/commandes.dart';
import 'package:jasser_terminal/providers/products.dart';
import 'package:jasser_terminal/screens/product/edit_product_screen.dart';
import 'package:jasser_terminal/screens/product/product_detail_screen.dart';
import 'package:jasser_terminal/widgets/swipe/delete_swipe.dart';
import 'package:jasser_terminal/widgets/swipe/edit_swipe.dart';
import 'package:provider/provider.dart';

class ShelfProductListDismissable extends StatelessWidget {
  const ShelfProductListDismissable({
    Key? key,
    required this.index,
    required this.shelfId,
    required this.productsData,
    required this.shopId,
  }) : super(key: key);

  final int index;
  final String shopId;
  final String shelfId;
  final Products productsData;

  @override
  Widget build(BuildContext context) {
    final commandeProvider = Provider.of<Commandes>(context, listen: true);
    Commande _commandeToAdd;
    Commande? _commandeToRemove;

    bool _isProductExistInCommande(String id) {
      return commandeProvider.commandes
          .any((commande) => commande.product.id == id);
    }

    bool _isCommandeExist(Commande _commandeToAdd) {
      for (var commande in commandeProvider.commandes) {
        if (commande.product.id == _commandeToAdd.product.id) {
          return true;
        }
      }
      return false;
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
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child: const Text(
                        "Supprimer",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Provider.of<Products>(context, listen: false)
                            .deleteProduct(productsData.products[index].id);
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                );
              });
          return res;
        } else {
          // Allez Sur la page Editer;
          Navigator.of(context).pushNamed(EditProductScreen.routeName,
              arguments: {
                'productId': productsData.products[index].id,
                'shelfId': shelfId
              });
        }
      },
      child: Card(
        child: ListTile(
          onTap: () {
            // Allez Sur la page Details;
            Navigator.of(context)
                .pushNamed(ProductDetailsScreen.routeName, arguments: {
              'productId': productsData.products[index].id,
              'shelfId': shelfId,
              'shopId': shopId
            });
          },
          visualDensity: VisualDensity.comfortable,
          leading: CircleAvatar(
            child: Text('${index + 1}'),
            radius: 20,
          ),
          title: Text(productsData.products[index].name),
          subtitle: Text(productsData.products[index].description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Imprimante widget
              IconButton(
                onPressed: () {
                  Printer.printProduct(
                      context,
                      productsData.products[index],
                      _qrCodeData(
                        productsData.products[index].id,
                        shelfId,
                        shopId,
                      ));
                },
                icon: const Icon(Icons.print_rounded),
              ),
              const SizedBox(width: 10),
              _isProductExistInCommande(productsData.products[index].id)
                  ? IconButton(
                      onPressed: () {
                        _commandeToRemove =
                            _findCommande(productsData.products[index].id);

                        if (_isProductExistInCommande(
                            productsData.products[index].id)) {
                          commandeProvider
                              .deleteCommande(_commandeToRemove)
                              .then(
                            (value) {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              return ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    'Produit supprimer de la liste des commandes',
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
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
                          product: productsData.products[index],
                        );

                        if (!_isCommandeExist(_commandeToAdd)) {
                          commandeProvider.addCommande(_commandeToAdd).then(
                            (value) {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              return ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    'Produit ajouté à la liste des commandes',
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.red,
                              content: Text(
                                  'Produit déjà dans la liste des commandes'),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.post_add_rounded),
                    ),
              // Icon(Icons.post_add_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
