import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavController extends GetxController {
  //observar a mudança do index
  var currentIndex = 0.obs;
  final PageController pageController = PageController(initialPage: 0);

  void changePage(int index) {
    currentIndex.value = index;
    //mudar instataneamente para a página 
    pageController.jumpToPage(index);
  }
  //descartar o controlar quando não for mais necessário 
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
