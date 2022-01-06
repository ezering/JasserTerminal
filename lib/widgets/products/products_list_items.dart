import 'package:flutter/material.dart';
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
  }) : super(key: key);

  final int index;
  final String shelfId;
  final Products productsData;

  @override
  Widget build(BuildContext context) {
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
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                arguments: {
                  'productId': productsData.products[index].id,
                  'shelfId': shelfId
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
            children: const <Widget>[
              Icon(Icons.print_outlined),
              SizedBox(width: 10),
              Icon(Icons.post_add_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
