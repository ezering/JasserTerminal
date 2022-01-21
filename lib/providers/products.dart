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
            price: product['price'].toDouble(),
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

  // add product to shelf
  Future<void> addProductToShelf(String shelfId, String name, double price,
      String quantity, String description) async {

    try {
      final response = await http.post(
        Uri.parse('${ApiClass.baseUrl}/products/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await ApiClass.getToken()}',
        },
        body: json.encode(
          {
            'shelfId': shelfId,
            'name': name,
            'price': price,
            'quantity': quantity,
            'description': description,
          },
        ),
      );
      final responseData = json.decode(response.body);
      _products.add(
        Product(
          id: responseData['product']['id'],
          name: responseData['product']['name'],
          description: responseData['product']['description'],
          price: responseData['product']['price'].toDouble(),
          quantity: responseData['product']['quantity'],
        ),
      );
      notifyListeners();
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
    } catch (error) {
      rethrow;
    }
  }

  // edit product on shelf
  Future<void> editProduct(
      String id, String shelfId, Product newProduct) async {
    try {
      final response = await http.patch(
        Uri.parse('${ApiClass.baseUrl}/products/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await ApiClass.getToken()}',
        },
        body: json.encode(
          {
            'name': newProduct.name,
            'shelfId': shelfId,
            'price': newProduct.price,
            'quantity': newProduct.quantity,
            'description': newProduct.description,
          },
        ),
      );
      final responseData = json.decode(response.body);
      final productIndex = _products.indexWhere((product) => product.id == id);
      _products[productIndex] = newProduct;
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
    } catch (error) {
      rethrow;
    }
  }

  // delete product on shelf
  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiClass.baseUrl}/products/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await ApiClass.getToken()}',
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      _products.removeWhere((product) => product.id == id);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
