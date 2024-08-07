import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/controller/village_controller.dart';
import 'package:teste/models/models_widget/models_widgets.dart';
import 'package:teste/screens/screen_personagens/personagens_vila.dart';

class VillagesPage extends StatelessWidget {
  const VillagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final VillageController controller = Get.put(VillageController());
    final PageController pageController = PageController(viewportFraction: 0.6,);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Verifica se há um índice salvo nos argumentos
      final int? savedPageIndex = Get.arguments?['pageIndex'];
      if (savedPageIndex != null) {
        pageController.jumpToPage(savedPageIndex);
      } else {
        pageController.jumpToPage(2); // Índice padrão
      }
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Naruto',
        subtitle: ' Universe',
      ),
      body: Stack(
        children: [
          const ImagemBackground(imagePath: 'lib/assets/assets/pain.jpg'),
          SafeArea(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.villages.isEmpty) {
                return const Center(child: Text('Nenhuma vila encontrada.'));
              } else {
                final List<String> imageAssets = [
                  'lib/assets/villages/konohagakure.jpg',
                  'lib/assets/villages/sunagakure.jpg',
                  'lib/assets/villages/kirigakure.jpg',
                  'lib/assets/villages/iwagakure.jpg',
                  'lib/assets/villages/kumogakure.jpg',
                ];

                return VillagePageView(
                  pageController: pageController,
                  imageAssets: imageAssets,
                  villageNames: controller.villages,
                  onPageSelected: (index) {
                    final List<int> villageIds = [16, 28, 14, 11, 17];
                    if (index >= 0 && index < villageIds.length) {
                      Get.to(() => VilaScreen(), arguments: {
                        'id': villageIds[index],
                        'name': controller.villages[index],
                        'pageIndex': index,
                      });
                    } else {
                      print('Índice inválido: $index');
                    }
                  },
                  initialPage: Get.arguments?['pageIndex'] ?? 2,
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
