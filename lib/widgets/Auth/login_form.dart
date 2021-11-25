// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        children: <Widget>[
          TextField(
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.purple,
                  width: 2,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.purple,
                  width: 2,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            obscureText: true,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              labelText: "Mot de passe",
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.purple,
                  width: 2,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.purple,
                  width: 2,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
