import 'package:jasser_terminal/models/shelf.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String quantity;
  final double price;
  final Shelf shelf;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.shelf,
  });
}
