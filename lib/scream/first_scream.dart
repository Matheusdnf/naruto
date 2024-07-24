import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/models_widget/models_butons.dart';
import 'package:teste/scream/screen_details_app/about.dart';
import 'package:teste/scream/screen_details_app/logo_app.dart';

class FirstScream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                      onPressed: (){
                        Get.to(const HomePage());
                      }
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
