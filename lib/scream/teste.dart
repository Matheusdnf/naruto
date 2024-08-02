import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teste/controller/controller_navigationbar.dart';
import 'home_scream.dart';

class Teste extends StatelessWidget {
  Teste({super.key});
  final NavController _navController = Get.find<NavController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //pageview gerenciar as páginas
      body: PageView(
        //controlador dos index apertados na nav bar
        controller: _navController.pageController,
        onPageChanged: (index) {
          //qual página carregar
          _navController.currentIndex.value = index;
        },
        children: _pages,
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}

final List<Widget> _pages = [
  const MyHomePage(),
];


class NavBar extends StatelessWidget {
  NavBar({super.key});
  final NavController _navController = Get.find<NavController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
        currentIndex: _navController.currentIndex.value,
        onTap: (index) {
          _navController.changePage(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Teste"),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back_ios_new), label: "Teste 2"),
        ],
      );
    });
  }
}