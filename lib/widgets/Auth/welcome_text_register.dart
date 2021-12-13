import 'package:flutter/material.dart';

class WelcomeTextRegister extends StatelessWidget {
  const WelcomeTextRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: const Text(
        'Veuillez vous inscrire!',
        style: TextStyle(
          color: Colors.purple,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
