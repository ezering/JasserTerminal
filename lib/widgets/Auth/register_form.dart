import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/providers/auth.dart';
import 'package:jasser_terminal/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> _formData = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      // Enregister l'utilisateur
      await Provider.of<Auth>(context, listen: false).signUp(
        _formData['firstName'] as String,
        _formData['lastName'] as String,
        _formData['email'] as String,
        _formData['password'] as String,
      );
      Display.dialogSuccess(
          context, 'Votre compte a été créé avec succès', const LoginScreen());
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nom'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir votre nom';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['firstName'] = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Prénom'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir votre prénom';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['lastName'] = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir votre email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['email'] = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir votre mot de passe';
                  } else if (value.length < 6) {
                    return 'Votre mot de passe doit contenir au moins 6 caractères';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['password'] = value!;
                },
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.save),
                      const SizedBox(width: 10),
                      Text(
                        'Enregistrer',
                        style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  onPressed: _submitForm,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
