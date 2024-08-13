import 'package:flutter/material.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Naruto ',
            style: TextStyle(
              fontSize: 100.0,
              fontFamily: 'NJNaruto',
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: 'Universe',
            style: TextStyle(
              fontSize: 100.0,
              fontFamily: 'NJNaruto',
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
