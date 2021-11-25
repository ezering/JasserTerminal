// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables, avoid_types_as_parameter_names, prefer_const_constructors, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import '../../widgets/Auth/login_form.dart';
import '../../widgets/Auth/welcome_text_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginAppBar(context),
      body: Column(
        children: <Widget>[
          const WelcomeText(),
          const LoginForm(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerRight,
            child: Text('Mot de passe oublié?',
                style: TextStyle(color: Colors.purple[500])),
          ),
          SizedBox(height: 60),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                  ),
                  side: BorderSide(
                    color: Colors.purple,
                  ),
                ),
                onPressed: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    'Créer un compte',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  AppBar LoginAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Se connecter', style: TextStyle(color: Colors.purple)),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.purple),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    );
  }
}
