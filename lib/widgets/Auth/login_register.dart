// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../../screens/auth/login_screen.dart';

class LoginAndRegisterButtons extends StatelessWidget {
  const LoginAndRegisterButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.purple[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
              ),
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.person_add_alt_1_sharp,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'S\'inscrire',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                  side: BorderSide(
                    color: Colors.purple[900]!.withOpacity(0.5),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.lock_rounded,
                      color: Colors.purple,
                    ),
                    const Text(
                      'Se Connecter',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
