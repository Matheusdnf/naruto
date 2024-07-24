import 'package:get/get.dart';
class BottomNavController extends GetxController {
  //observar a mudança do index (toque no botão)
  var currentIndex = 0.obs;
  //realizar a mudança de págia 
  void changePage(int index) {
    //pega a mudança do index e atrela a uma varíavel
    currentIndex.value = index;
    switch (index) {
      case 0:
        print("Primeiro Botão");
        break;
      case 1:
        print("Segundo botão");
        break;
      case 2:
        // Lógica de navegação para a página de Grupos
        print("Terceiro botão ");
        break;
      default:
        Get.toNamed('/'); // Página padrão
    }
  }
}
