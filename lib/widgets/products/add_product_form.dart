import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/models/shelf.dart';
import 'package:jasser_terminal/providers/shelfs.dart';
import 'package:jasser_terminal/providers/shops.dart';
import 'package:provider/provider.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> _formData = {
    'name': '',
    'price': '',
    'quantity': '',
    'description': '',
  };
  var _isInit = true;
  var _isLoading = false;
  var _selectedShop;
  var _selectedShelf;

  List<Shelf> _shelfs = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        Provider.of<Shops>(context, listen: false).fetchAndSetShops().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      } catch (error) {
        Display.dialogError(context, error);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    // Ajout du shelf
    try {
      // await Provider.of<Shelfs>(context, listen: false).addShelf(widget.shopId,
      //     _formData['name'] as String, _formData['description'] as String);
      // _formKey.currentState!.reset();
      // Display.dialogSuccess(context, "Etage ajouté avec succès");
    } catch (error) {
      Display.dialogError(context, error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var shopProvider = Provider.of<Shops>(context);
    List<Shelf> getCorrespondingShelfToShop(_selectedShop) {
      if (_selectedShop != null) {
        return [];
      } else {
        return [];
      }
    }

    //  List<Shelf> getCorrespondingShelfToShop(Shops shopProvider) {
    //   var shelfs = shopProvider.shopShelfs
    //       .where((shelf) => shelf.shop?.id == _selectedShop)
    //       .toList();
    //   return shelfs;
    // }

    // find in shopProvider.shopShelfs the shelfs with shop.id = _selectedShop
    // _shelfs = getCorrespondingShelfToShop(_selectedShop);

    // get shelfs from shopProvider.shops based on _selectedShop
    // var shelfs = shopProvider.shops
    //     .firstWhere((shop) => shop.id == _selectedShop)
    //     .shelfs;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Selectionner la boutique',
              ),
              items: shopProvider.shops.map((shop) {
                return DropdownMenuItem(
                  value: shop.id,
                  child: Text(shop.name),
                );
              }).toList(),
              onChanged: (value) => setState(() {
                _selectedShop = value as String;
                _shelfs = [];
                _shelfs = getCorrespondingShelfToShop(_selectedShop);
              }),
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Selectionner l\'étagere.',
              ),
              items: _shelfs.map((shelf) {
                return DropdownMenuItem(
                  value: shelf.id,
                  child: Text(shelf.name),
                );
              }).toList(),
              // shelfs.map((shelf) {
              //   return DropdownMenuItem(
              //     value: shelf.id,
              //     child: Text(shelf.name),
              //   );
              // }).toList(),
              onChanged: (value) => setState(() {
                _selectedShelf = value as String;
              }),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nom'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer un nom de l\'étagère';
                }
                return null;
              },
              onSaved: (value) {
                _formData['name'] = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Prix'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer le prix du produit';
                }
                return null;
              },
              onSaved: (value) {
                _formData['price'] = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Quantité'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer la quantité';
                }
                return null;
              },
              onSaved: (value) {
                _formData['price'] = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Déscription'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer la déscription du produit';
                }
                return null;
              },
              onSaved: (value) {
                _formData['description'] = value!;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Valider'),
              onPressed: _submitForm,
            ),
            const SizedBox(height: 20),
            _isLoading ? const CircularProgressIndicator() : Container(),
          ],
        ),
      ),
    );
  }
}
