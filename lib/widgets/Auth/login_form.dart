import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/providers/auth.dart';
import 'package:jasser_terminal/screens/auth/forgot_pass_screen.dart';
import 'package:jasser_terminal/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
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
      await Provider.of<Auth>(context, listen: false).signIn(
        _formData['email'] as String,
        _formData['password'] as String,
      );
      // y'a mieux que ça : Question: pourquoi le Consumer dans Main ne fait rien.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const HomeScreen(),
        ),
      );
    } catch (error) {
      Display.dialogError(context, error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    // setState(() {
    //   _isLoading = false;
    // });

    // print(_formData);
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
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty ||
                      !value.contains('@') ||
                      !value.contains('.')) {
                    return 'Format de l\'email invalide!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['email'] = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mot de passe'),

                obscureText: true,
                controller: _passwordController,
                // cursorColor: Colors.grey,
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Mot de passe doit avoir au moins 6 caractères.';
                  }
                },
                onSaved: (value) {
                  _formData['password'] = value!;
                },
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ForgotPassScreen.routeName);
                  },
                  child: Text('Mot de passe oublié?',
                      softWrap: true,
                      style: TextStyle(color: Colors.purple[500])),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                  ),
                  onPressed: _submitForm,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Connexion',
                          style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor,
                              fontSize: 18),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.login_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
