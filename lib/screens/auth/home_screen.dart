import 'package:flutter/material.dart';
import 'package:jasser_terminal/screens/auth/forgot_pass_screen.dart';
import '../../widgets/Auth/login_register.dart';

class AuthHomeScreen extends StatelessWidget {
  static const routeName = '/auth-home';
  const AuthHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/Flutter.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: const Text(
                'Bienvenue, \nJasser Terminal.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const LoginAndRegisterButtons(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  ForgotPassScreen.routeName,
                ),
                child: const Text(
                  'Mot de passe oublié ?',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
