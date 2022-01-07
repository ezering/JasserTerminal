import 'package:flutter/material.dart';
import 'package:jasser_terminal/providers/shelfs.dart';
import 'package:jasser_terminal/widgets/shelf/shelf_items.dart';
import 'package:provider/provider.dart';

class ShelfList extends StatelessWidget {
  static const routeName = '/shelf-list';
  const ShelfList({Key? key, required this.shopId}) : super(key: key);
  final String shopId;
  @override
  Widget build(BuildContext context) {
    final shelfData = Provider.of<Shelfs>(context);
    return shelfData.shelfs.isNotEmpty
        ? GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 8 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            children: List.generate(
              shelfData.shelfs.length,
              (index) => ShelfItemDismissable(
                shopId: shopId,
                shelfData: shelfData.shelfs[index],
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Aucune étagère trouvée',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          );
  }
}
