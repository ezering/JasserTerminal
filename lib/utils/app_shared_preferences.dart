import 'dart:convert';

import 'package:jasser_terminal/models/commande.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setCommandeList(List<Commande> commandeList) async {
    // print("##############");
    // print("Encode JSON: $jsonEncode(commandeList.toEncodable)");
    // print("##############");
    String jsonCommandeList = jsonEncode(commandeList);
    await _preferences.setString("commandeList", jsonCommandeList);
  }

  static Future<List<Commande>> getCommandeList() async {
    var commandeList = _preferences.getString("commandeList") as dynamic;
    if (commandeList == null) {
      // print("onGet: commandeList is null from shared preferences");
      return [];
    }

    // print("onGet: commandeList is not null from shared preferences");
    // get data from shared preferences
    List<Commande> commandeListFromSharedPreferences =
        (jsonDecode(commandeList) as List)
            .map((data) => Commande.fromJson(data))
            .toList();
    // print("##############");
    // print("Decode JSON: $commandeListFromSharedPreferences");
    // print("Commande List Lenght: ${commandeListFromSharedPreferences.length}");
    // print("##############");

    return commandeListFromSharedPreferences;
  }

  static Future deleteCommandeListPref() async {
    // check if commandeList is null shared preferences
    var commandeList = _preferences.getString("commandeList") as dynamic;
    if (commandeList == null) {
      // print("OnDelete: commandeList is null from shared preferences");
      return;
    }
    await _preferences.remove("commandeList");
    // print("commandeList is deleted from shared preferences");
  }
}
