import 'package:flutter/material.dart';

class LogoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'DRAGON',
            style: TextStyle(
              fontSize: 100.0,
              fontFamily: 'Pacifico',
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: 'DEX',
            style: TextStyle(
              fontSize: 100.0,
              fontFamily: 'Pacifico',
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
