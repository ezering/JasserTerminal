import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jasser_terminal/models/http_exception.dart';
import 'package:jasser_terminal/models/product.dart';
import 'package:jasser_terminal/models/shelf.dart';
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

  Future<void> fetchAndSetShelfs() async {
    final response = await http.get(
      Uri.parse('${ApiClass.baseUrl}/shelfs'),
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
            products: loadedProducts,
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
    // switch (errorData.statusCode) {
    //   case 401:
    //     throw HttpException(
    //         "Vous n'êtes pas autorisé à accéder à cette ressource");
    //   case 400:
    //     throw HttpException("Vous n'avez pas entré de données valides");
    //   case 404:
    //     throw HttpException("Aucun shop trouvé");
    //   case 500:
    //     throw HttpException(
    //         "Une erreur interne est survenue, veuillez réessayer plus tard");
    //   default:
    //     throw HttpException(
    //       'Unexpected error ${response.statusCode}',
    //     );
    // }
  }
}
