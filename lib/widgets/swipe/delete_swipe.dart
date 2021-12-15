import 'package:flutter/material.dart';

class DeleteSwipe extends StatelessWidget {
  const DeleteSwipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Text(
              "Supprimer",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.delete_sweep,
              color: Colors.white,
              size: 40,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
