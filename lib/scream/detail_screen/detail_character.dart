import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teste/models/model_character.dart';

class Detalhedocaracter extends StatelessWidget{ 
  @override
  Widget build(BuildContext context){
    final Character personagem = Get.arguments as Character;
    return Scaffold(
      appBar:AppBar(
        title: Text(personagem.name),
      ),
      body: Padding(
        padding:const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Row(
                 children: personagem.images.isNotEmpty ?
                    personagem.images.map((imagens)=>
                    Image.network(
                      imagens,
                      height: 122,
                      width: 122,
                      fit: BoxFit.cover,
                    ),
                    ).toList() :[Container()],
              ),
            ),
            SizedBox(height: 10),
             Text('Jutsus:', style: TextStyle(fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: personagem.jutsu.isNotEmpty? 
              personagem.jutsu.map((jutsu) => Text('- $jutsu')).toList()
               :[Text("Tem nada aqui não colega")],

            ),
            SizedBox(height: 10),
            Text('Estreia:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Mangá: ${personagem.debut.manga ?? 'Não especificado'}'),

          ],
        ),
      ),
    );
  }
}
                    
                  
