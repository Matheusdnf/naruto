import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:teste/controler/village_controller.dart';
import 'dart:ui'; // Importe o controlador

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final VillageController controller = Get.put(VillageController());

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
                  'web/assets/assets/pain.jpg',
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
                  'web/assets/villages/konohagakure.jpg',
                  'web/assets/villages/sunagakure.jpg',
                  'web/assets/villages/kirigakure.jpg',
                  'web/assets/villages/iwagakure.jpg',
                  'web/assets/villages/kumogakure.jpg',
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
                  onPageChanged: (page) {
                    print('Página mudada para $page');
                  },
                  onSelectedItem: (index) {
                    print('Item selecionado no índice $index');
                  },
                );
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Villages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Clans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Grupos',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.red,
        onTap: (index) {
          // Handle navigation logic based on the selected index if needed
        },
      ),
    );
  }
}
