import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jasser_terminal/models/http_exception.dart';
import 'package:jasser_terminal/providers/api.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Auth with ChangeNotifier {
  String? _token;

  String? get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  bool get isAuth {
    if (token != null && !JwtDecoder.isExpired(token!)) {
      return true;
    }
    return false;
  }

// S'enregistrer avec les données de l'utilisateur
  Future<void> signUp(
      String firstName, String lastName, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Api.BASE_URL}/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
        }),
      );
      final responseData = await json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      rethrow;
    }
  }

  // Se connecter avec les données de l'utilisateur
  Future<void> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Api.BASE_URL}/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      final responseData = await json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['message']);
      } else {
        _token = responseData['accessToken'] as String;
        notifyListeners();
      }
      // _token = responseData['accessToken'] as String;
      // notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
