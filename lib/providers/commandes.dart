import 'package:flutter/widgets.dart';
import 'package:jasser_terminal/models/commande.dart';
import 'package:jasser_terminal/utils/app_shared_preferences.dart';

class Commandes extends ChangeNotifier {
  List<Commande> _commandes = [];

  List<Commande> get commandes {
    return [..._commandes];
  }

  // set commandes
  Future<void> fetchAndSetCommandes() async {
    List<Commande> savedCommandes = [];
    savedCommandes = await AppSharedPreferences.getCommandeList();
    print("##############");
    print("Saved Commandes = $savedCommandes");
    print("Saved Commandes Length= ${savedCommandes.length}");
    print("##############");
    _commandes = savedCommandes;
    notifyListeners();
  }

  Future<void> getCommandes() async {
    // get from shared preferences
    if (_commandes.isEmpty) {
      _commandes = await AppSharedPreferences.getCommandeList();
      notifyListeners();
    }
  }

  Future<void> addCommande(Commande commande) async {
    if (!_commandes.contains(commande)) {
      _commandes.add(commande);

      notifyListeners();
      await AppSharedPreferences.deleteCommandeListPref();
      await AppSharedPreferences.setCommandeList(_commandes);
    }
  }

  Future<void> deleteCommande(Commande? commande) async {
    if (_commandes.contains(commande)) {
      _commandes.remove(commande);
      notifyListeners();
      await AppSharedPreferences.deleteCommandeListPref();
      await AppSharedPreferences.setCommandeList(_commandes);
    }
  }

  Future<void> deleteAllCommandes() async {
    _commandes.clear();
    notifyListeners();
    await AppSharedPreferences.deleteCommandeListPref();
    await AppSharedPreferences.setCommandeList(_commandes);
  }

  Future<Commande> getOneCommande(String id) async {
    return _commandes.firstWhere((commande) => commande.id == id);
  }
}
