import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/controler/caracter_controler.dart';
import 'package:teste/models/model_caracter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CaracterController characterController =
        Get.put(CaracterController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens de Naruto'),
      ),
      body: Obx(() {
        if (characterController.isLoading.value) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Exemplo de indicador de carregamento
        } else if (characterController.characters.isNotEmpty) {
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
        } else if (characterController.characters.isEmpty &&
            !characterController.isLoading.value) {
          return Center(
            child: Text(
                'Não foi possível carregar os personagens'), // Exibe uma mensagem indicando que não foi possível carregar os
          );
        } else {
          return Center(child: Text('Erro desconhecido'));
        }
      }),
    );
  }
}
