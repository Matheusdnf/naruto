import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste/controller/controller_navigationbar.dart';
import 'package:teste/scream/teste.dart';

class ModelButton {
  String nome;
  Icon icon;
  VoidCallback? onPressed;

  ModelButton({required this.nome, required this.icon, required this.onPressed});
}

class MyButton extends StatelessWidget {
  final List<ModelButton> modelo;

  MyButton({this.modelo = const []});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: modelo
          .map(
            (guia) => IconButton(
              icon: guia.icon,
              tooltip: guia.nome,
              onPressed: guia.onPressed,
            ),
          )
          .toList(),
    );
  }
}

class InfoDev extends StatelessWidget{
  final String name;
  final String image; 
  final List<ModelButton> socialmedia;

  InfoDev({required this.name,required this.image,required this.socialmedia
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'lib/assets/assets/desc.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                Text(
                  'Redes Sociais:',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 2),
                MyButton(
                  modelo: socialmedia,
                )

              ]
            ) 
          ]
        )
      ]
    );
  }
}


class ButtonInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          Get.put(NavController());
          Get.to(()=> Teste());
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          backgroundColor: Colors.black,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow, color: Colors.yellowAccent),
            SizedBox(width: 8),
            Text(
              'Abrir aplicativo',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
