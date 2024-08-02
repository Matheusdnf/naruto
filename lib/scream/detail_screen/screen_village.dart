import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/controller/village_controller.dart';
import 'package:teste/scream/detail_screen/detail_character.dart';
import 'package:teste/models/model_character.dart';

class VilaScreen extends StatefulWidget {
  const VilaScreen({super.key});

  @override
  _VilaScreenState createState() => _VilaScreenState();
}

class _VilaScreenState extends State<VilaScreen> {
  late String name;
  final VillageController controller = Get.find(); // Usa o mesmo controlador já instanciado

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>;
    final int villageId = arguments['id']; // Recebe o ID da vila passado como argumento
    name = arguments['name'];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchCharacter(villageId); // Busca os personagens da vila selecionada
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ninjas de $name'),
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
              final Character vila = controller.vila[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4, // elevação para dar um efeito de sombra
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // bordas arredondadas
                ),
                child: ListTile(
                  leading: Container(
                    width: 50, // Define a largura do contêiner
                    height: 50, // Define a altura do contêiner
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0), // Define o raio da borda arredondada
                      child: Image.network(
                        vila.images.isNotEmpty ? vila.images[0] : 'Nenhuma Imagem carregada',
                        fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço disponível
                      ),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: Text(vila.name),
                  subtitle: Text('ID: ${vila.id}'),
                  onTap: () {
                    Get.to(() => Detalhedocaracter(), arguments: vila);
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
