import 'package:flutter/widgets.dart';
import 'package:jasser_terminal/models/commande.dart';

class Commandes extends ChangeNotifier {
  List<Commande> _commandes = [];

  List<Commande> get commandes {
    return [..._commandes];
  }

  void addCommande(Commande commande) {
    if (!_commandes.contains(commande)) {
      _commandes.add(commande);
      notifyListeners();
    }
  }
}
