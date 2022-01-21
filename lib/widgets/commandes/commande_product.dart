import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/commande.dart';
import 'package:jasser_terminal/providers/commandes.dart';
import 'package:jasser_terminal/screens/product/product_detail_screen.dart';
import 'package:provider/provider.dart';

class CommandeProducts extends StatefulWidget {
  static const routeName = '/commande-products';
  const CommandeProducts({Key? key, required this.commandes}) : super(key: key);
  final List<Commande> commandes;

  @override
  State<CommandeProducts> createState() => _CommandeProductsState();
}

class _CommandeProductsState extends State<CommandeProducts> {
  var _isInit = true;
  var _isLoading = false;
  late List<Commande> _commandesList;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
        _commandesList = widget.commandes;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final commandeProvider = Provider.of<Commandes>(context, listen: true);

    Commande? _commandeToRemove;

    Commande? _findCommande(String id) {
      for (var commande in _commandesList) {
        if (commande.product.id == id) {
          return commande;
        }
      }
      return null;
    }

    void _removeCommande(String id) {
      setState(() {
        _commandeToRemove = _findCommande(id);
        _commandesList.removeAt(_commandesList.indexOf(_commandeToRemove!));
      });
    }

    bool _isProductExistInCommande(String id) {
      return _commandesList.any((commande) => commande.product.id == id);
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () {
              // Allez Sur la page Details;
              Navigator.of(context)
                  .pushNamed(ProductDetailsScreen.routeName, arguments: {
                'productId': _commandesList[index].product.id,
                'shelfId': _commandesList[index].shelfId,
                'shopId': _commandesList[index].shopId
              });
            },
            visualDensity: VisualDensity.comfortable,
            leading: CircleAvatar(
              child: Text('${index + 1}'),
              radius: 20,
            ),
            title: Text(_commandesList[index].product.name),
            subtitle: Text(_commandesList[index].product.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Icon(Icons.print_outlined),
                const SizedBox(width: 10),

                IconButton(
                  onPressed: () {
                    _commandeToRemove =
                        _findCommande(_commandesList[index].product.id);
                    if (_isProductExistInCommande(
                        _commandesList[index].product.id)) {
                      commandeProvider.deleteCommande(_commandeToRemove).then(
                        (value) {
                          _removeCommande(_commandesList[index].product.id);
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          return ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.green,
                              content: Text(
                                'Produit supprimer de la liste des commandes',
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: _commandesList.length,
    );
  }
}
