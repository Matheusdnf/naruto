import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/controler/caracter_controler.dart';
import 'package:teste/models/model_caracter.dart'; // Verifique o caminho do seu modelo

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CaracterController characterController =
        Get.put(CaracterController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens de Naruto'),
      ),
      body: Obx(() {
        if (characterController.characters.isEmpty) {
          // Caso não haja personagens carregados ainda
          return const Center(
              child: Text('deu ruim')); // Exemplo de indicador de carregamento
        } else {
          // Caso haja personagens carregados
          return ListView.builder(
            itemCount: characterController.characters.length,
            itemBuilder: (context, index) {
              final Caracter character = characterController.characters[index];
              return ListTile(
                title: Text(character.name),
                subtitle: Text('ID: ${character.id}'),
                onTap: () {
                  // Aqui você pode adicionar a navegação para detalhes do personagem
                },
              );
            },
          );
        }
      }),
    );
  }
}
