// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String label;
  final void Function() onChange;

  const InputTextField({
    required this.label,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: null,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        labelText: label,
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
    );
  }
}
