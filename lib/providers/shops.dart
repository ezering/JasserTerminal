import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jasser_terminal/models/http_exception.dart';
import 'package:jasser_terminal/models/shop.dart';
import 'package:jasser_terminal/providers/api_class.dart';

class Shops extends ChangeNotifier {
  List<Shop> _shops = [];

  List<Shop> get shops {
    return [..._shops];
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
      for (var shop in responseData) {
        loadedShops.add(
          Shop(
            id: shop['id'],
            name: shop['name'],
            address: shop['address'],
          ),
        );
      }
      _shops = loadedShops;
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
