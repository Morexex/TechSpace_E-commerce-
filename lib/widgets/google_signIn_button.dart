// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleLogInButton extends StatelessWidget {
  final Function() onPressed;
  const GoogleLogInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.fromLTRB(50, 50, 50, 20),
    child: Material(
      elevation: 3,
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(6),
      child: MaterialButton(
        onPressed:onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(
              FontAwesomeIcons.google,
              color: Colors.red,
            ),
            Text(
              'Sign In With Google',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    ),
  );
  }
}
