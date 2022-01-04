import 'package:jasser_terminal/models/product.dart';
import 'package:jasser_terminal/models/shop.dart';

class Shelf {
  final String id;
  final String name;
  final String description;
  final List<Product> products;

  Shelf({
    required this.id,
    required this.name,
    required this.description,
    required this.products,
  });

  
}
