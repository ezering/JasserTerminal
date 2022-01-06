import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/providers/shops.dart';
import 'package:provider/provider.dart';

class AddShopForm extends StatefulWidget {
  const AddShopForm({Key? key}) : super(key: key);

  @override
  State<AddShopForm> createState() => _AddShopFormState();
}

class _AddShopFormState extends State<AddShopForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> _formData = {
    'name': '',
    'location': '',
  };
  var _isLoading = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    // Ajout du shop...
    try {
      await Provider.of<Shops>(context, listen: false).addShop(
        _formData['name'] as String,
        _formData['location'] as String,
      );
      _formKey.currentState!.reset();
      Navigator.of(context).pop();

      Display.dialogSuccess(context, "Boutique ajoutée avec succès");
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
                  return 'Veuillez entrer un nom de magasin';
                }
                return null;
              },
              onSaved: (value) {
                _formData['name'] = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Localité'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer la localité du magasin';
                }
                return null;
              },
              onSaved: (value) {
                _formData['location'] = value!;
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
