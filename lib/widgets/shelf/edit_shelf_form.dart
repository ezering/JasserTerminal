import 'package:flutter/material.dart';

class EditShelfForm extends StatefulWidget {
  const EditShelfForm({Key? key}) : super(key: key);

  @override
  State<EditShelfForm> createState() => _EditShelfFormState();
}

class _EditShelfFormState extends State<EditShelfForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> _formData = {
    'name': '',
    'description': '',
  };
  var _isLoading = false;

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    // Send request
    setState(() {
      _isLoading = false;
    });
    print(_formData);
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
