import 'package:flutter/material.dart';

class EditSwipe extends StatelessWidget {
  const EditSwipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.mode_edit_outlined,
              color: Colors.white,
              size: 30,
            ),
            Text(
              " Editer",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
