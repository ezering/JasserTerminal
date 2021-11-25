import 'package:flutter/material.dart';
import '../../screens/home_screen.dart';
import '../../widgets/Auth/login_register.dart';
import '../../widgets/Auth/slider_points.dart';

class AuthHomeScreen extends StatelessWidget {
  const AuthHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/Flutter.png',
            fit: BoxFit.cover,
          ),
          const SliderPoints(),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: const Text(
              'Welcome to Jasser Terminal.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.brown,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 60),
          const LoginAndRegisterButtons(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen())),
              child: const Text(
                'Mot de passe oublié ?',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
