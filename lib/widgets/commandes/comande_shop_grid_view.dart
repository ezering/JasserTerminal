import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/commande.dart';
import 'package:jasser_terminal/models/shop.dart';
import 'package:jasser_terminal/providers/commandes.dart';
import 'package:jasser_terminal/providers/shops.dart';
import 'package:provider/provider.dart';

import 'commande_shop_items.dart';

class CommandeShopGridView extends StatelessWidget {
  const CommandeShopGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commandesData = Provider.of<Commandes>(context);
    final shopsData = Provider.of<Shops>(context);
    List<String> shopIds = [];
    List<Shop> shops = [];
    // List<Commande> commandes = [];

    for (var i = 0; i < commandesData.commandes.length; i++) {
      if (!shopIds.contains(commandesData.commandes[i].shopId)) {
        shopIds.add(commandesData.commandes[i].shopId);
      }
    }

    for (var i = 0; i < shopIds.length; i++) {
      shops.add(shopsData.findById(shopIds[i]));
    }

    // Method to get commandes for each shop
    List<Commande> getCommandesForShop(Shop shop) {
      List<Commande> commandesForShop = [];
      for (var i = 0; i < commandesData.commandes.length; i++) {
        if (commandesData.commandes[i].shopId == shop.id) {
          commandesForShop.add(commandesData.commandes[i]);
        }
      }
      return commandesForShop;
    }

    // List<Commande> getCommandesForShop(String shopId) {
    //   List<Commande> commandes = [];
    //   for (var i = 0; i < commandesData.commandes.length; i++) {
    //     if (commandesData.commandes[i].shopId == shopId) {
    //       commandes.add(commandesData.commandes[i]);
    //     }
    //   }
    //   return commandes;
    // }

    // void getCommandesForShop(Shop shop) {
    //   for (var i = 0; i < commandesData.commandes.length; i++) {
    //     if (commandesData.commandes[i].shopId == shop.id) {
    //       commandes.add(commandesData.commandes[i]);
    //     }
    //   }
    // }

    // for (var i = 0; i < shops.length; i++) {
    //   for (var j = 0; j < commandesData.commandes.length; j++) {
    //     if (commandesData.commandes[j].shopId == shops[i].id) {
    //       commandes.add(commandesData.commandes[j]);
    //     }
    //   }
    // }

    // for (var i = 0; i < commandesData.commandes.length; i++) {
    //   if (commandesData.commandes[i].shopId == shops[0].id) {
    //     commandes.add(commandesData.commandes[i]);
    //   }
    // }

    // print("shopIds: $shopIds");
    // print("shops: $shops");
    // print("commandes: $commandes");
    // print("Commande List Length: ${commandes.length}");

    return commandesData.commandes.isNotEmpty
        ? GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 8 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            children: List.generate(
              shops.length,
              (index) => CommandeShopItemDismissable(
                  shopCommande: shops[index],
                  commandes: getCommandesForShop(shops[index])),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Aucune Liste trouvée dans les boutiques',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          );
  }
}
