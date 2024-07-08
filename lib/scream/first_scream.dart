import 'package:flutter/material.dart';
import 'package:teste/models_widget/models_butons.dart';
import 'package:teste/scream/logo_app.dart';

class FirstScream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alguma coisa',
      home: Scaffold(
        backgroundColor: Colors.orange,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: ButonInformation(
                  modelo: [
                    ModelButtonInformation(
                      nome: 'Desenvolvedores',
                      icon: const Icon(Icons.people_alt_outlined),
                    ),
                    ModelButtonInformation(
                      nome: 'Sobre',
                      icon: const Icon(Icons.integration_instructions),
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoApp(),
                    const SizedBox(height: 10),
                    ButtonInicial(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}