import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/models/models_widget/models_widgets.dart';
import 'package:teste/repository/repository_groups.dart';
import '../../controller/groups_controller.dart';
import '../screen_personagens/personagens_grupos.dart';

class GruposPage extends StatelessWidget {
  const GruposPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Instancia o controlador
    final GrupoController grupoController = Get.put(GrupoController());

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Naruto',
        subtitle: ' Universe',
      ),
      body: Stack(
        children: [
          const ImagemBackground(imagePath: 'lib/assets/assets/akatsoca.jpg'),
          SafeArea(
            child: Obx(() {
              if (grupoController.errorMessage.value.isNotEmpty) {
                return Center(child: Text(grupoController.errorMessage.value));
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Selecione um grupo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'NJNaruto',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 80), // Espaço entre o texto e os botões
                      _buildGroupButton(context, 'Akatsuki',Group.akatsuki ),
                      SizedBox(height: 20), // Espaço entre os botões
                      _buildGroupButton(context, 'Tailed Beasts', Group.tailedBeast),
                      SizedBox(height: 20), // Espaço entre os botões
                      _buildGroupButton(context, 'Kara', Group.kara),
                    ],
                  ),
                );
              }
            })
          ),
        ]
      ),
    );
  }

  Widget _buildGroupButton(BuildContext context, String groupName, Group group) {
    return ElevatedButton(
      onPressed: () {
        // Atualiza o índice do grupo selecionado
        Get.to(() => GroupScreen(), arguments: {
          'name': groupName,
          'index': group,
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.black, padding:const EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
      child: Text(
        groupName,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'NJNaruto',
          letterSpacing: 1.2,
          shadows: [
            Shadow(
              offset: Offset(1.0, 1.0),
              blurRadius: 3.0,
              color: Colors.black.withOpacity(0.8),
            ),
          ],
        ),
      ),
    );
  }
}
