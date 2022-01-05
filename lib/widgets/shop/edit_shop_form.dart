import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/models/shop.dart';
import 'package:jasser_terminal/providers/shops.dart';
import 'package:provider/provider.dart';

class EditShopForm extends StatefulWidget {
  const EditShopForm({Key? key}) : super(key: key);

  @override
  State<EditShopForm> createState() => _EditShopFormState();
}

class _EditShopFormState extends State<EditShopForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _editedShop = Shop(
    id: '',
    name: '',
    address: '',
    shelfs: [],
  );

  var _initValues = {
    'name': '',
    'address': '',
  };
  var _isLoading = false;
  final _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final shopId = ModalRoute.of(context)!.settings.arguments as String;

      _editedShop = Provider.of<Shops>(context, listen: false).findById(shopId);
      _initValues = {
        'name': _editedShop.name,
        'address': _editedShop.address,
      };
    }
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
    // edit shop
    try {
      await Provider.of<Shops>(context, listen: false)
          .updateShop(_editedShop.id, _editedShop);
      Display.dialogSuccess(context, "Boutique modifiée avec succès");
    } catch (error) {
      Display.dialogError(context, error.toString());
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
                  return 'Veuillez entrer un nom de magasin';
                }
                return null;
              },
              onSaved: (value) {
                _editedShop = Shop(
                  id: _editedShop.id,
                  name: value ?? _editedShop.name,
                  address: _editedShop.address,
                  shelfs: _editedShop.shelfs,
                );
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Localité'),
              initialValue: _initValues['address'],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer la localité du magasin';
                }
                return null;
              },
              onSaved: (value) {
                _editedShop = Shop(
                  id: _editedShop.id,
                  name: _editedShop.name,
                  address: value ?? _editedShop.address,
                  shelfs: _editedShop.shelfs,
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
