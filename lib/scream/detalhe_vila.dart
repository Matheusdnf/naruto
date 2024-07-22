import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/models/model_vila.dart';
import 'package:teste/scream/detalhesdocaracter.dart';

class DetalheVila extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    final Vila vila = Get.arguments as Vila;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(vila.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Personagens:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            ...vila.personagem.map((personagem) => ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
              title: Text(personagem.name),
              onTap: () {
                Get.to(() => Detalhedocaracter(), arguments: personagem);
              },
            )).toList(),
          ],
        ),
      ),
    );
  }
}
