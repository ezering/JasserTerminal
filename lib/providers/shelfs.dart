import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jasser_terminal/models/http_exception.dart';
import 'package:jasser_terminal/models/product.dart';
import 'package:jasser_terminal/models/shelf.dart';
import 'package:jasser_terminal/models/shop.dart';
import 'package:jasser_terminal/providers/api_class.dart';

class Shelfs extends ChangeNotifier {
  List<Shelf> _shelfs = [];
  List<Product> _productsOnShelf = [];

  List<Shelf> get shelfs {
    return [..._shelfs];
  }

  List<Product> get productsOnShelf {
    return [..._productsOnShelf];
  }

  Shelf findById(String id) {
    return _shelfs.firstWhere((shelf) => shelf.id == id);
  }

  Product findProductById(String id) {
    return _productsOnShelf.firstWhere((product) => product.id == id);
  }

  Future<void> fetchAndSetShelfs(Shop shop) async {
    final response = await http.get(
      Uri.parse('${ApiClass.baseUrl}/shelfs/byshop/${shop.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await ApiClass.getToken()}',
      },
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body) as List<dynamic>;
      final List<Shelf> loadedShelfs = [];
      final List<Product> loadedProducts = [];

      for (var shelf in responseData) {
        for (var i = 0; i < shelf['products'].length; i++) {
          loadedProducts.add(
            Product(
              id: shelf['products'][i]['id'],
              name: shelf['products'][i]['name'],
              price: shelf['products'][i]['price'],
              description: shelf['products'][i]['description'],
              quantity: shelf['products'][i]['quantity'],
            ),
          );
        }
        loadedShelfs.add(
          Shelf(
            id: shelf['id'],
            name: shelf['name'],
            description: shelf['description'],
            shop: Shop(
              id: '',
              name: '',
              address: '',
              shelfs: [],
            ),
          ),
        );
      }
      _shelfs = loadedShelfs;
      _productsOnShelf = loadedProducts;
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
        throw Exception('Erreur de chargement des étagères');
      }
    }
  }

  // add shelf
  Future<void> addShelf(String id, String name, String description) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiClass.baseUrl}/shelfs/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await ApiClass.getToken()}',
        },
        body: json.encode(
          <String, String>{
            'id': id,
            'name': name,
            'description': description,
          },
        ),
      );
      final responseData = json.decode(response.body);
      _shelfs.add(
        Shelf(
          id: responseData['shelf']['id'],
          name: responseData['shelf']['name'],
          description: responseData['shelf']['description'],
          shop: Shop(
            id: responseData['shelf']['shop']['id'],
            name: responseData['shelf']['shop']['name'],
            address: responseData['shelf']['shop']['address'],
            shelfs: [],
          ),
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

// update shelf
  Future<void> updateShelf(String id, Shelf newShelf) async {
    try {
      final response = await http.patch(
        Uri.parse('${ApiClass.baseUrl}/shelfs/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await ApiClass.getToken()}',
        },
        body: json.encode(
          <String, dynamic>{
            'name': newShelf.name,
            'description': newShelf.description,
          },
        ),
      );
      final responseData = json.decode(response.body);
      final shelfIndex = _shelfs.indexWhere((shelf) => shelf.id == id);
      _shelfs[shelfIndex] = newShelf;
      notifyListeners();
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
    } catch (error) {
      rethrow;
    }
  }

  // delete shelf
  Future<void> deleteShelf(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiClass.baseUrl}/shelfs/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await ApiClass.getToken()}',
        },
      );
      final responseData = json.decode(response.body);
      final shelfIndex = _shelfs.indexWhere((shelf) => shelf.id == id);
      _shelfs.removeAt(shelfIndex);
      notifyListeners();
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
    } catch (error) {
      rethrow;
    }
  }
}
