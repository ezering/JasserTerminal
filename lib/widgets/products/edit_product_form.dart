import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/models/product.dart';
import 'package:jasser_terminal/providers/products.dart';
import 'package:provider/provider.dart';

class EditProductForm extends StatefulWidget {
  const EditProductForm({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProductForm> createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: '', name: '', price: 0, quantity: '', description: '');

  var _initValues = {
    'name': '',
    'price': '',
    'quantity': '',
    'description': '',
  };

  var _isInit = true;
  var _isLoading = false;

  var _productId;
  var _shelfId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final String productId = arguments['productId'] as String;
      _productId = productId;
      final String shelfId = arguments['shelfId'] as String;
      _shelfId = shelfId;
      _editedProduct =
          Provider.of<Products>(context, listen: false).findById(productId);

      _initValues = {
        'name': _editedProduct.name,
        'price': _editedProduct.price.toString(),
        'quantity': _editedProduct.quantity,
        'description': _editedProduct.description,
      };
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
    // Ajout produit
    try {
      await Provider.of<Products>(context, listen: false).editProduct(
        _editedProduct.id,
        _shelfId,
        _editedProduct,
      );
      Navigator.of(context).pop();

      Display.dialogSuccess(context, "Produit modifié avec succès");
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nom'),
              initialValue: _initValues['name'],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer un nom du produit';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  id: _editedProduct.id,
                  name: value ?? _editedProduct.name,
                  price: _editedProduct.price,
                  quantity: _editedProduct.quantity,
                  description: _editedProduct.description,
                );
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Prix'),
              initialValue: _initValues['price'],
              keyboardType: TextInputType.number,
              // keyboardAppearance: Brightness.dark,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer le prix du produit';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  id: _editedProduct.id,
                  name: _editedProduct.name,
                  price: double.parse(value ?? _editedProduct.price.toString()),
                  quantity: _editedProduct.quantity,
                  description: _editedProduct.description,
                );
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Quantité'),
              initialValue: _initValues['quantity'],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer la quantité';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  id: _editedProduct.id,
                  name: _editedProduct.name,
                  price: _editedProduct.price,
                  quantity: value ?? _editedProduct.quantity,
                  description: _editedProduct.description,
                );
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Déscription'),
              initialValue: _initValues['description'],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer la déscription du produit';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  id: _editedProduct.id,
                  name: _editedProduct.name,
                  price: _editedProduct.price,
                  quantity: _editedProduct.quantity,
                  description: value ?? _editedProduct.description,
                );
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
