import 'package:jasser_terminal/models/shelf.dart';

class Shop {
  final String id;
  final String name;
  final String address;
  final List<Shelf> shelfs;

  Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.shelfs,
  });
}
