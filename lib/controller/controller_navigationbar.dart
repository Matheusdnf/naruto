import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavController extends GetxController {
  var currentIndex = 0.obs;
  final PageController pageController = PageController();

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
