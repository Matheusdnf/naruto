import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:teste/controller/controller_navigationbar.dart';
import 'package:teste/scream/detail_screen/screen_village.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:teste/controller/village_controller.dart';
import 'dart:ui'; 


class MyHomePage extends StatelessWidget {
  const MyHomePage ({super.key});
  @override
  Widget build(BuildContext context) {
    final VillageController controller = Get.put(VillageController());
    // final BottomNavController bottomNavController = Get.put(BottomNavController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vilas de Naruto'),
        backgroundColor: Colors.transparent, // Torna a AppBar transparente
        elevation: 0, // Remove a sombra da AppBar
      ),
      body: Stack(
        children: [
          // Container para a imagem com desfoque
          Positioned.fill(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'lib/assets/assets/pain.jpg',
                  fit: BoxFit.cover,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.2), // Ajusta a opacidade para melhorar a legibilidade
                  ),
                ),
              ],
            ),
          ),
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

                final List<Widget> cards = imageAssets.asMap().entries.map((entry) {
                  int index = entry.key;
                  String path = entry.value;
                  return Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Image.asset(
                            path,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            color: Colors.black.withOpacity(0.5),
                            child: Text(
                              controller.villages[index],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'NJNaruto',
                                fontSize: 24.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList();

                return VerticalCardPager(
                  titles: controller.villages.map((name) => '').toList(),
                  images: cards,
                  // onPageChanged: (page) {
                  //   print('Página mudada para $page');
                  // },
                  onSelectedItem: (index) {
                    // Defina os IDs das vilas em uma lista
                    final List<int> villageIds = [16, 28, 14, 11, 17];

                    // Verifique se o índice é válido
                    if (index >= 0 && index < villageIds.length) {
                      // Navegue para a tela de vilas passando o ID correspondente
                      Get.to(() => VilaScreen(), arguments: {
                        'id': villageIds[index],
                        'name': controller.villages[index]
                      });
                    } else {
                      // Opcional: lidar com casos em que o índice não é válido
                      print('Índice inválido: $index');
                    }
                  },
                );
              }
            }),
          ),
        ],
      ),
      // bottomNavigationBar: Obx(() {
      //   //atualização do estado do ícone 
      //   return BottomNavigationBar(
      //     items: const <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: 'Villages',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.search),
      //         label: 'Clans',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Grupos',
      //       ),
      //     ],
      //     //item selecionado atualmente na nav bar (atual)
      //     currentIndex: bottomNavController.currentIndex.value,
      //     //item selecionado fica na cor vermelha 
      //     selectedItemColor: Colors.red,
      //     //ao clicar irá mandar para a mudança de página
      //     onTap: bottomNavController.changePage,
      //   );
      // }),
    );
  }
}
