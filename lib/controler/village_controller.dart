import 'package:get/get.dart';

class VillageController extends GetxController {
  var villages = <String>[].obs; // Lista de nomes das vilas
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Defina as vilas específicas aqui
    villages.value = [
      'Konohagakure',
      'Sunagakure',
      'Kirigakure',
      'Iwagakure',
      'Kumogakure',
    ];
    isLoading.value = false; // Atualize conforme necessário
  }
}
