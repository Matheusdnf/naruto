import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/controler/village_controller.dart';
import 'package:teste/models/model_caracter.dart';
import 'package:teste/models/model_vila.dart';
import 'package:teste/scream/detalhesdocaracter.dart';

class VilaScreen extends StatefulWidget {
  const VilaScreen({super.key});

  @override
  _VilaScreenState createState() => _VilaScreenState();
}

class _VilaScreenState extends State<VilaScreen> {
  final VillageController controller = Get.find(); // Usa o mesmo controlador já instanciado

  @override
  void initState() {
    super.initState();
    final int villageId = Get.arguments; // Recebe o ID da vila passado como argumento
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchCharacter(villageId); // Busca os personagens da vila selecionada
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens de Naruto'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.vila.isEmpty) {
          return const Center(child: Text('Nenhum personagem encontrado.'));
        } else {
          return ListView.builder(
            itemCount: controller.vila.length,
            itemBuilder: (context, index) {
              final Caracter vila = controller.vila[index];
              return ListTile(
                title: Text(vila.name),
                subtitle: Text('ID: ${vila.id}'),
                onTap: () {
                  // Aqui você pode exibir uma lista de personagens em vez da própria vila
                  Get.to(() => Detalhedocaracter(), arguments: vila);
                },
              );
            },
          );
        }
      }),
    );
  }
}
