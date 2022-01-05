import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/providers/auth.dart';
import 'package:provider/provider.dart';

enum AuthMode { signUp, login }

class AuthenticationScreen extends StatelessWidget {
  static const routeName = '/authentication';

  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: deviceSize.height,
              width: deviceSize.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 1],
                ),
              ),
            ),
            SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  Map<String, String> _formData = {
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
    if (_authMode == AuthMode.login) {
      try {
        await Provider.of<Auth>(context, listen: false).signIn(
          _formData['email'] as String,
          _formData['password'] as String,
        );
      } catch (error) {
        Display.dialogError(context, error);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      try {
        // Enregister l'utilisateur
        await Provider.of<Auth>(context, listen: false).signUp(
          _formData['firstName'] as String,
          _formData['lastName'] as String,
          _formData['email'] as String,
          _formData['password'] as String,
        );
        Display.dialogSuccess(context, 'Votre compte a été créé avec succès');
        _authMode = AuthMode.login;
        _formKey.currentState?.reset();
      } catch (error) {
        Display.dialogError(context, error);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signUp;
      });
      _formKey.currentState?.reset();
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
      _formKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        child: Container(
          height: _authMode == AuthMode.signUp ? 450 : 300,
          constraints: BoxConstraints(
              minHeight: _authMode == AuthMode.signUp ? 450 : 300),
          width: deviceSize.width * 0.90,
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  if (_authMode == AuthMode.signUp)
                    TextFormField(
                      enabled: _authMode == AuthMode.signUp,
                      decoration: const InputDecoration(labelText: 'Nom'),
                      keyboardType: TextInputType.text,
                      validator: _authMode == AuthMode.signUp
                          ? (value) {
                              if (value!.isEmpty) {
                                return 'Veuillez saisir votre nom';
                              }
                            }
                          : null,
                      onSaved: (value) {
                        _formData['firstName'] = value!;
                      },
                    ),
                  if (_authMode == AuthMode.signUp)
                    TextFormField(
                      enabled: _authMode == AuthMode.signUp,
                      decoration: const InputDecoration(labelText: 'Prénom'),
                      keyboardType: TextInputType.text,
                      validator: _authMode == AuthMode.signUp
                          ? (value) {
                              if (value!.isEmpty) {
                                return 'Veuillez saisir votre prénom';
                              }
                            }
                          : null,
                      onSaved: (value) {
                        _formData['lastName'] = value!;
                      },
                    ),
                  if (_authMode == AuthMode.signUp ||
                      _authMode == AuthMode.login)
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return "L'adresse email n'est pas valide.";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _formData['email'] = value!;
                      },
                    ),
                  if (_authMode == AuthMode.signUp ||
                      _authMode == AuthMode.login)
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Mot de passe'),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Le mot de passe est trop court.';
                        }
                      },
                      onSaved: (value) {
                        _formData['password'] = value!;
                      },
                    ),
                  if (_authMode == AuthMode.signUp)
                    const SizedBox(
                      height: 20,
                    ),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    const SizedBox(
                      height: 30,
                    ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      shadowColor: Colors.black,
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
                            _authMode == AuthMode.login
                                ? 'Connexion'
                                : 'Inscription',
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontSize: 18),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            _authMode == AuthMode.login
                                ? Icons.login_outlined
                                : Icons.person_add_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: _switchAuthMode,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 4),
                      child: Text(
                        _authMode == AuthMode.login
                            ? 'Nouveau ?... Créer un compte'
                            : 'Vous avez déjà un compte ?',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
