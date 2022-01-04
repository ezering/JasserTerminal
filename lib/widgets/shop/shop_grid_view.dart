import 'package:flutter/material.dart';
import 'package:jasser_terminal/providers/shops.dart';
import 'package:jasser_terminal/widgets/shop/shop_item_dismissable.dart';
import 'package:provider/provider.dart';

class ShopGridView extends StatelessWidget {
  const ShopGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shopData = Provider.of<Shops>(context);

    return shopData.shops.isNotEmpty
        ? GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 4 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: List.generate(
              shopData.shops.length,
              (index) => ShopItemDismissable(
                shopData: shopData.shops[index],
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Aucune Boutique trouvée',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          );
  }
}
