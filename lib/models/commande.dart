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

  Map<String, dynamic> toJson() => {
        'id': id,
        'shopId': shopId,
        'shelfId': shelfId,
        'product': product.toJson(),
      };

  factory Commande.fromJson(Map<String, dynamic> json) => Commande(
        id: json['id'],
        shopId: json['shopId'],
        shelfId: json['shelfId'],
        product: Product.fromJson(json['product']),
      );
}
