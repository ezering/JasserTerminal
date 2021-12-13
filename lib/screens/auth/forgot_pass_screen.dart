import 'package:flutter/material.dart';
import 'package:jasser_terminal/widgets/Auth/forgot_pass_form.dart';
import 'package:jasser_terminal/widgets/Auth/welcome_text_forgotpass.dart';

import 'home_screen.dart';

class ForgotPassScreen extends StatelessWidget {
  static const routeName = '/forgot-pass';
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: forgotPassAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            WelcomeTextForgotPass(),
            ForgotPassForm(),
          ],
        ),
      ),
    );
  }

  AppBar forgotPassAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Restauration Mot de Passe',
          style: TextStyle(color: Colors.purple)),
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.purple),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(AuthHomeScreen.routeName);
          }),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    );
  }
}
