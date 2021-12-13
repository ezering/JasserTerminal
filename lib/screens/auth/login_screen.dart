import 'package:flutter/material.dart';
import 'package:jasser_terminal/screens/auth/home_screen.dart';
import '../../widgets/Auth/login_form.dart';
import '../../widgets/Auth/welcome_text_login.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loginAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            WelcomeTextLogin(),
            LoginForm(),
          ],
        ),
      ),
    );
  }

  AppBar loginAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Connexion', style: TextStyle(color: Colors.purple)),
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
