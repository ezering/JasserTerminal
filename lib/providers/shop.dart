import 'package:flutter/widgets.dart';
import 'package:jasser_terminal/providers/product.dart';

class Shop extends ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  // List<Product> get favoriteItems {
  //   return _items.where((prodItem) => prodItem.isFavorite).toList();
  // }

  // Product findById(String id) {
  //   return _items.firstWhere((prod) => prod.id == id);
  // }

  // void addProduct(Product product) {
  //   final newProduct = Product(
  //     id: DateTime.now().toString(),
  //     title: product.title,
  //     description: product.description,
  //     price: product.price,
  //     imageUrl: product.imageUrl,
  //   );
  //   _items.add(newProduct);
  //   notifyListeners();
  // }
}
