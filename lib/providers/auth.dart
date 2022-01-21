import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jasser_terminal/models/http_exception.dart';
import 'package:jasser_terminal/providers/api_class.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token = '';
  String _email = '';
  bool isAuthenticated = false;

  String get token {
    if (_token.isNotEmpty) {
      return _token;
    }
    return '';
  }

  bool get isAuth {
    if (token.isNotEmpty && !JwtDecoder.isExpired(token)) {
      isAuthenticated = true;
      return true;
    }
    isAuthenticated = false;
    return false;
  }

// S'enregistrer avec les données de l'utilisateur
  Future<void> signUp(
      String firstName, String lastName, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiClass.baseUrl}/auth/signup'),
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
        Uri.parse('${ApiClass.baseUrl}/auth/login'),
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
      _token = responseData['accessToken'];
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        <String, String>{
          'token': responseData['accessToken'],
          'email': responseData['email'],
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  // get extracted user data
  Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return <String, dynamic>{
        'token': '',
        'email': '',
      };
    }

    final extractedUserData = json
        .decode(prefs.getString('userData') as dynamic) as Map<String, dynamic>;
    final token = extractedUserData['token'];
    final email = extractedUserData['email'];
    return <String, dynamic>{
      'token': token,
      'email': email,
    };
  }

  // auto authentification
  Future<bool> autoAuthenticate() async {
    // print('auto authentification');
    final extractedUserData = await getUserData();
    final token = extractedUserData['token'] as String;
    final email = extractedUserData['email'] as String;
    // print(token);
    // print(email);

    if (token.isNotEmpty && !JwtDecoder.isExpired(token)) {
      _token = token;
      _email = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  // logout
  Future<void> logout() async {
    _token = '';
    _email = '';
    isAuthenticated = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
    // await prefs.clear();
  }

  // auto logout :: Not used
  Future<void> autoLogout() async {
    if (_token.isNotEmpty) {
      if (JwtDecoder.isExpired(_token)) {
        await logout();
      }
    }
  }
}
