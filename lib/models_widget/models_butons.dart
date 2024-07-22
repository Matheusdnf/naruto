import 'package:flutter/material.dart';
import 'package:teste/scream/home_scream.dart';
import 'package:get/get.dart';

class ModelButtonInformation {
  String nome;
  Icon icon;
  VoidCallback? onPressed;

  ModelButtonInformation({required this.nome, required this.icon, required this.onPressed});
}

class ButonInformation extends StatelessWidget {
  final List<ModelButtonInformation> modelo;

  ButonInformation({this.modelo = const []});

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

class ButtonInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          Get.to(MyHomePage());
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
