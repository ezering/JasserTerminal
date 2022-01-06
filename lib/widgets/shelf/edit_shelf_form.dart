import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/models/shelf.dart';
import 'package:jasser_terminal/models/shop.dart';
import 'package:jasser_terminal/providers/shelfs.dart';
import 'package:provider/provider.dart';

class EditShelfForm extends StatefulWidget {
  const EditShelfForm({Key? key}) : super(key: key);

  @override
  State<EditShelfForm> createState() => _EditShelfFormState();
}

class _EditShelfFormState extends State<EditShelfForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _editedShelf = Shelf(
      id: '',
      name: '',
      description: '',
      shop: Shop(id: 'id', name: '', address: '', shelfs: []));

  var _initValues = {
    'name': '',
    'description': '',
  };

  final _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final shelfId = ModalRoute.of(context)!.settings.arguments as String;
      _editedShelf =
          Provider.of<Shelfs>(context, listen: false).findById(shelfId);
      _initValues = {
        'name': _editedShelf.name,
        'description': _editedShelf.description,
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
    // edit shelf
    try {
      await Provider.of<Shelfs>(context, listen: false)
          .updateShelf(_editedShelf.id, _editedShelf);

      Display.dialogSuccess(context, "étagère modifiée avec succès");
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
                  return "Veuillez entrer un nom de l'étagère";
                }
                return null;
              },
              onSaved: (value) {
                _editedShelf = Shelf(
                  id: _editedShelf.id,
                  name: value ?? _editedShelf.name,
                  description: _editedShelf.description,
                  shop: _editedShelf.shop,
                );
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Déscription'),
              initialValue: _initValues['description'],
              validator: (value) {
                if (value!.isEmpty) {
                  return "Veuillez entrer la déscription de l'étagere";
                }
                return null;
              },
              onSaved: (value) {
                _editedShelf = Shelf(
                  id: _editedShelf.id,
                  name: _editedShelf.name,
                  description: value ?? _editedShelf.description,
                  shop: _editedShelf.shop,
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
