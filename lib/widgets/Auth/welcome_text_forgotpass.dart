import 'package:flutter/material.dart';

class WelcomeTextForgotPass extends StatelessWidget {
  const WelcomeTextForgotPass({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: const Text(
        'Veuillez saisir votre addresse e-mail et on vous enverra un nouveau mot de passe!',
        style: TextStyle(
          color: Colors.purple,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
