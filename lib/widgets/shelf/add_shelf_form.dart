import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/providers/shelfs.dart';
import 'package:provider/provider.dart';

class AddShelfForm extends StatefulWidget {
  const AddShelfForm({Key? key, required this.shopId}) : super(key: key);
  final String shopId;

  @override
  State<AddShelfForm> createState() => _AddShelfFormState();
}

class _AddShelfFormState extends State<AddShelfForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> _formData = {
    'name': '',
    'description': '',
  };
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
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
      await Provider.of<Shelfs>(context, listen: false).addShelf(widget.shopId,
          _formData['name'] as String, _formData['description'] as String);
      _formKey.currentState!.reset();
      Display.dialogSuccess(context, "Etage ajouté avec succès");
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
                  return 'Veuillez entrer un nom de l\'étagère';
                }
                return null;
              },
              onSaved: (value) {
                _formData['name'] = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Déscription'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer la déscription de l\étagere';
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
