import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jasser_terminal/models/http_exception.dart';
import 'package:jasser_terminal/models/product.dart';
import 'package:jasser_terminal/models/shelf.dart';
import 'package:jasser_terminal/providers/api_class.dart';

class Products extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<void> fetchAndSetProducts(Shelf shelf) async {
    final response = await http.get(
      Uri.parse('${ApiClass.baseUrl}/products/byshelf/${shelf.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await ApiClass.getToken()}',
      },
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body) as List<dynamic>;
      final List<Product> loadedProducts = [];
      for (var product in responseData) {
        loadedProducts.add(
          Product(
            id: product['id'],
            name: product['name'],
            description: product['description'],
            price: product['price'],
            quantity: product['quantity'],
          ),
        );
      }
      _products = loadedProducts;
      notifyListeners();
    } else {
      if (response.statusCode == 401) {
        throw HttpException(
            "Vous n'êtes pas autorisé à accéder à cette ressource");
      } else if (response.statusCode == 404) {
        throw HttpException(
            "Une erreur est survenue lors de la récupération des données");
      } else if (response.statusCode == 500) {
        throw HttpException("Erreur interne du serveur");
      } else {
        throw Exception('Erreur de chargement des boutiques');
      }
    }
  }
}
