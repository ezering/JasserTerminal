import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jasser_terminal/models/http_exception.dart';
import 'package:jasser_terminal/providers/api.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token = '';
  String _email = '';

  String get token {
    if (_token.isNotEmpty) {
      return _token;
    }
    return '';
  }

  bool get isAuth {
    if (token.isNotEmpty && !JwtDecoder.isExpired(token)) {
      return true;
    }
    return false;
  }

// S'enregistrer avec les données de l'utilisateur
  Future<void> signUp(
      String firstName, String lastName, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Api.baseUrl}auth/signup'),
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
        Uri.parse('${Api.baseUrl}auth/login'),
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
      }
      // else {
      //   _token = responseData['accessToken'] as String;
      //   notifyListeners();
      // }
      _token = responseData['accessToken'];
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'email': email,
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  // auto authentification
  Future<bool> autoAuthenticate() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData') ?? '') as Map<String, Object>;
    final token = extractedUserData['token'] as String;
    final email = extractedUserData['email'] as String;

    if (token.isNotEmpty && JwtDecoder.isExpired(token)) {
      return false;
    }
    _token = token;
    _email = email;

    notifyListeners();
    return true;
  }
}
