import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/models_widget/models_widgets.dart';
import 'package:teste/scream/screen_details_app/about.dart';
import 'package:teste/scream/screen_details_app/logo_app.dart';

class FirstScream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Naruto Universe',
      home: Scaffold(
        backgroundColor: Colors.orange,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: MyButton(
                  modelo: [
                    ModelButton(
                      nome: 'Desenvolvedores',
                      icon: const Icon(Icons.people_alt_outlined),
                      onPressed: (){
                        Get.to(AboutPage());
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
