import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/providers/products.dart';
import 'package:provider/provider.dart';

class AddProductFormWithShelfId extends StatefulWidget {
  const AddProductFormWithShelfId({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProductFormWithShelfId> createState() =>
      _AddProductFormWithShelfIdState();
}

class _AddProductFormWithShelfIdState extends State<AddProductFormWithShelfId> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {
    'name': '',
    'price': '',
    'quantity': '',
    'description': '',
  };
  var _isInit = true;
  var _isLoading = false;

  var _shelfId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final shelfId = ModalRoute.of(context)!.settings.arguments as String;
      _shelfId = shelfId;
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
      await Provider.of<Products>(context, listen: false).addProductToShelf(
        _shelfId,
        _formData['name'] as String,
        double.parse(_formData['price']),
        _formData['quantity'] as String,
        _formData['description'] as String,
      );

      _formKey.currentState!.reset();
      Navigator.of(context).pop();
      Display.dialogSuccess(context, "Produit ajouté avec succès");
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer un nom du produit';
                }
                return null;
              },
              onSaved: (value) {
                _formData['name'] = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Prix'),
              keyboardType: TextInputType.number,
              // keyboardAppearance: Brightness.dark,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer le prix du produit';
                }
                return null;
              },
              onSaved: (value) {
                double.parse(_formData['price'] = value!);
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
                _formData['quantity'] = value!;
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
