import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ApiClass {
  static const String baseUrl = "https://jasser-terminal-server.herokuapp.com";

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return null;
    }

    final extractedUserData = json
        .decode(prefs.getString("userData") as dynamic) as Map<String, dynamic>;
    final token = extractedUserData["token"];
    return token;
  }
}
