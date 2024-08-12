import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/models/models_widget/models_widgets.dart';
import 'package:teste/repository/repository_groups.dart';
import '../../controller/groups_controller.dart';
import '../screen_personagens/personagens_grupos.dart';

// Tela que exibe opções de grupos para o usuário selecionar
class GruposPage extends StatelessWidget {
  const GruposPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Instancia o controlador GrupoController com GetX
    final GrupoController grupoController = Get.put(GrupoController());

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Naruto', // Título do AppBar
        subtitle: ' Universe', // Subtítulo do AppBar
      ),
      body: Stack(
        children: [
          // Fundo da tela com imagem
          const ImagemBackground(imagePath: 'lib/assets/assets/akatsoca.jpg'),
          SafeArea(
            child: Obx(() {
              // Observa mudanças no controlador usando GetX
              if (grupoController.errorMessage.value.isNotEmpty) {
                // Se houver uma mensagem de erro, exibe-a
                return Center(child: Text(grupoController.errorMessage.value));
              } else {
                // Caso contrário, exibe os botões de seleção de grupo
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Centraliza os itens na coluna
                    crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os itens na coluna
                    children: [
                      const Text(
                        'Selecione um grupo', // Texto informativo
                        style: TextStyle(
                          color: Colors.white, // Cor do texto
                          fontSize: 30, // Tamanho da fonte
                          fontFamily: 'NJNaruto', // Fonte personalizada
                          fontWeight: FontWeight.bold, // Peso da fonte
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
        // Navega para a tela de grupo com o nome e o índice do grupo como argumentos
        Get.to(() => const GroupScreen(), arguments: {
          'name': groupName,
          'index': group,
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, // Cor do texto do botão
        backgroundColor: Colors.black, // Cor de fundo do botão
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30) // Espaçamento interno do botão
      ),
      child: Text(
        groupName, // Nome do grupo no botão
        style: TextStyle(
          fontSize: 20, // Tamanho da fonte
          fontFamily: 'NJNaruto', // Fonte personalizada
          letterSpacing: 1.2, // Espaçamento entre letras
          shadows: [
            Shadow(
              offset: const Offset(1.0, 1.0), // Deslocamento da sombra
              blurRadius: 3.0, // Raio de desfoque da sombra
              color: Colors.black.withOpacity(0.8), // Cor da sombra com opacidade
            ),
          ],
        ),
      ),
    );
  }
}
