import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jasser_terminal/models/shop.dart';
import 'package:jasser_terminal/providers/api_class.dart';

class Shops extends ChangeNotifier {
  List<Shop> _shops = [];

  List<Shop> get shops {
    return [..._shops];
  }

  Future<void> fetchAndSetShops() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiClass.baseUrl}/shops'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await ApiClass.getToken()}',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as List<dynamic>;
        final List<Shop> loadedShops = [];
        for (var shop in jsonResponse) {
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
        throw Exception('Failed to load shops');
      }
      notifyListeners();
    } catch (error) {
      print(error);
      throw Exception('Failed to load shops');
    }
  }
}
