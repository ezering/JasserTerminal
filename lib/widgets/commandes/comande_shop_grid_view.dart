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
    final commandesData = Provider.of<Commandes>(context, listen: true);
    final shopsData = Provider.of<Shops>(context, listen: true);
    List<String> shopIds = [];
    List<Shop> shops = [];

    for (var i = 0; i < commandesData.commandes.length; i++) {
      if (!shopIds.contains(commandesData.commandes[i].shopId)) {
        shopIds.add(commandesData.commandes[i].shopId);
      }
    }

    for (var i = 0; i < shopIds.length; i++) {
      shops.add(shopsData.findById(shopIds[i]));
    }

    List<Commande> getCommandesForShop(Shop shop) {
      List<Commande> commandesForShop = [];
      for (var i = 0; i < commandesData.commandes.length; i++) {
        if (commandesData.commandes[i].shopId == shop.id) {
          commandesForShop.add(commandesData.commandes[i]);
        }
      }
      return commandesForShop;
    }

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
                'Aucune Liste de commandes trouvée dans les boutiques',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          );
  }
}
