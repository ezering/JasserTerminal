import 'package:jasser_terminal/models/shop.dart';

class Shelf {
  final String id;
  final String name;
  final String description;
  final Shop shop;
  // final List<Product> products;

  Shelf({
    required this.id,
    required this.name,
    required this.description,
    required this.shop,
    // required this.products,
  });
}
