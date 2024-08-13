import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/controller/village_controller.dart';
import 'package:teste/models/models_widget/models_widgets.dart';
import 'package:teste/screens/screen_personagens/personagens_vila.dart';

class VillagesPage extends StatelessWidget {
  const VillagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializa o controlador de vilas usando o GetX.
    final VillageController controller = Get.put(VillageController());

    // Controlador para o PageView, definindo a fração de visualização.
    final PageController pageController = PageController(viewportFraction: 0.6);

    // Após a construção do widget, verifica se há um índice de página salvo nos argumentos.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final int? savedPageIndex = Get.arguments?['pageIndex'];
      if (savedPageIndex != null) {
        pageController.jumpToPage(savedPageIndex);
      } else {
        pageController.jumpToPage(2); // Define a página inicial padrão.
      }
    });

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Naruto',
        subtitle: ' Universe',
      ),
      body: Stack(
        children: [
          // Imagem de fundo.
          const ImagemBackground(imagePath: 'lib/assets/assets/pain.jpg'),
          SafeArea(
            child: Obx(() {
              if (controller.isLoading.value) {
                // Exibe um indicador de progresso enquanto os dados são carregados.
                return const Center(child: CircularProgressIndicator());
              } else if (controller.villages.isEmpty) {
                // Mensagem caso nenhuma vila seja encontrada.
                return const Center(child: Text('Nenhuma vila encontrada.'));
              } else {
                // Lista de caminhos para as imagens das vilas.
                final List<String> imageAssets = [
                  'lib/assets/villages/konohagakure.jpg',
                  'lib/assets/villages/sunagakure.jpg',
                  'lib/assets/villages/kirigakure.jpg',
                  'lib/assets/villages/iwagakure.jpg',
                  'lib/assets/villages/kumogakure.jpg',
                ];

                // Configura o PageView personalizado com as vilas.
                return VillagePageView(
                  pageController: pageController,
                  imageAssets: imageAssets,
                  villageNames: controller.villages,
                  onPageSelected: (index) {
                    final List<int> villageIds = [16, 28, 14, 11, 17];
                    if (index >= 0 && index < villageIds.length) {
                      // Navega para a tela específica da vila selecionada.
                      Get.to(() => const VilaScreen(), arguments: {
                        'id': villageIds[index],
                        'name': controller.villages[index],
                        'pageIndex': index,
                      });
                    } else {
                      print('Índice inválido: $index');
                    }
                  },
                  initialPage: Get.arguments?['pageIndex'] ?? 2, //
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
