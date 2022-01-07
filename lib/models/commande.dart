import 'package:jasser_terminal/models/product.dart';

class Commande {
  final String id;
  final String shopId;
  final String shelfId;
  final Product product;

  Commande(
      {required this.id,
      required this.shopId,
      required this.shelfId,
      required this.product});
}
