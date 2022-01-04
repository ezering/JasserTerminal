import 'package:flutter/material.dart';
import 'package:jasser_terminal/providers/products.dart';
import 'package:jasser_terminal/widgets/products/products_list_items.dart';
import 'package:provider/provider.dart';

class ShelfProductsList extends StatelessWidget {
  const ShelfProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return productsData.products.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) {
              return ShelfProductListDismissable(
                  index: index, productsData: productsData);
            },
            itemCount: productsData.products.length,
          )
        : Container(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Aucun produit trouvé',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          );
  }
}
