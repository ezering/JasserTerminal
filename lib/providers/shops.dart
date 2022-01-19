import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jasser_terminal/models/http_exception.dart';
import 'package:jasser_terminal/models/shelf.dart';
import 'package:jasser_terminal/models/shop.dart';
import 'package:jasser_terminal/providers/api_class.dart';

class Shops extends ChangeNotifier {
  List<Shop> _shops = [];
  List<Shelf> _shopShelfs = [];

  List<Shop> get shops {
    return [..._shops];
  }

  List<Shelf> get shopShelfs {
    return [..._shopShelfs];
  }

  Shop findById(String id) {
    return _shops.firstWhere((shop) => shop.id == id);
  }

  Future<void> fetchAndSetShops() async {
    final response = await http.get(
      Uri.parse('${ApiClass.baseUrl}/shops'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await ApiClass.getToken()}',
      },
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body) as List<dynamic>;
      final List<Shop> loadedShops = [];
      final List<Shelf> loadedShelfs = [];
      for (var shop in responseData) {
        for (var i = 0; i < shop['shelfs'].length; i++) {
          loadedShelfs.add(
            Shelf(
              id: shop['shelfs'][i]['id'],
              name: shop['shelfs'][i]['name'],
              description: shop['shelfs'][i]['description'],
              shop: Shop(
                id: shop['id'],
                name: shop['name'],
                address: shop['address'],
                shelfs: [],
              ),
            ),
          );
        }
        loadedShops.add(
          Shop(
              id: shop['id'],
              name: shop['name'],
              address: shop['address'],
              shelfs: loadedShelfs),
        );
      }
      _shops = loadedShops;
      _shopShelfs = loadedShelfs;
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

  // Add Shop
  Future<void> addShop(String name, String address) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiClass.baseUrl}/shops/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await ApiClass.getToken()}',
        },
        body: json.encode(
          <String, String>{
            'name': name,
            'address': address,
          },
        ),
      );
      final responseData = json.decode(response.body);

      _shops.add(
        Shop(
            id: responseData["shop"]['id'],
            name: responseData["shop"]['name'],
            address: responseData["shop"]['address'],
            shelfs: _shopShelfs),
      );
      notifyListeners();
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
    } catch (error) {
      rethrow;
    }
  }

  // Update Shop
  Future<void> updateShop(String id, Shop newShop) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiClass.baseUrl}/shops/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await ApiClass.getToken()}',
        },
        body: json.encode(
          <String, String>{
            'name': newShop.name,
            'address': newShop.address,
          },
        ),
      );
      final responseData = json.decode(response.body);
      final shopIndex = _shops.indexWhere((shop) => shop.id == id);
      _shops[shopIndex] = newShop;
      notifyListeners();
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
    } catch (error) {
      rethrow;
    }
  }

  // Delete Shop
  Future<void> deleteShop(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiClass.baseUrl}/shops/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await ApiClass.getToken()}',
        },
      );
      final responseData = json.decode(response.body);
      _shops.removeWhere((shop) => shop.id == id);
      notifyListeners();
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
    } catch (error) {
      rethrow;
    }
  }
}
