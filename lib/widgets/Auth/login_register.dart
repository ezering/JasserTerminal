import 'package:flutter/material.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/auth/login_screen.dart';

class LoginAndRegisterButtons extends StatelessWidget {
  const LoginAndRegisterButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(RegisterScreen.routeName);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.person_add_alt_1_sharp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
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
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                  side: const BorderSide(
                    color: Colors.purple,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  LoginScreen.routeName,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.lock_open,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Se Connecter',
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
        ],
      ),
    );
  }
}
