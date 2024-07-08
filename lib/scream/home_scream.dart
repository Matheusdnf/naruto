import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/controler/caracter_controler.dart';
import 'package:teste/models/model_caracter.dart'; // Verifique o caminho do seu modelo
import 'package:teste/repository/repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CaracterController controller = Get.put(CaracterController(Caracterreposity()));
  final ScrollController _scrollController = ScrollController(); //Criamos um ScrollController para monitorar o movimento de rolagem do usuário.

  @override
  void initState() { //Adicionamos um listener ao ScrollController para detectar quando o usuário atinge o final da lista e chamar fetchCharacters para carregar mais dados.
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        controller.fetchCharacters();
      }
    });
  }

  @override
  void dispose() { //Garantimos que o ScrollController seja limpo corretamente para evitar vazamentos de memória.
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens de Naruto'),
      ),
      body: Obx(() {
        if (controller.characters.isEmpty && controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator()); // exibimos um CircularProgressIndicator indicando que mais dados estão sendo carregados.
        } else if (controller.characters.isEmpty && !controller.isLoading.value) {
          return const Center(child: Text('Nenhum personagem encontrado.')); // Caso não haja personagens
        } else {
          return ListView.builder(
            controller: _scrollController,
            itemCount: controller.characters.length + (controller.isLoading.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.characters.length) {
                final Caracter character = controller.characters[index];
                return ListTile(
                  title: Text(character.name),
                  subtitle: Text('ID: ${character.id}'),
                  onTap: () {
                    // Aqui você pode adicionar a navegação para detalhes do personagem
                  },
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        }
      }),
    );
  }
}