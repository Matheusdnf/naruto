import 'package:get/get.dart';
import 'package:teste/models/model_vila.dart';
import 'package:teste/repository/repository_vila.dart';

class VillageController extends GetxController {
  var villages = <String>[].obs;
  var isLoading = true.obs;
  var vila = <Vila>[].obs;
  var selectedVillageId = 0.obs;

  final Vilareposity vilareposity = Vilareposity(); // Instância do repositório

  @override
  void onInit() {
    super.onInit();
    villages.value = [
      'Konohagakure',
      'Sunagakure',
      'Kirigakure',
      'Iwagakure',
      'Kumogakure',
    ];
    isLoading.value = false;
  }

  void fetchVila(int villageId) async {
    try {
      isLoading(true);
      selectedVillageId.value = villageId;
      final List<Vila> fetchedVila = await vilareposity.getVila(villageId);
      vila.assignAll(fetchedVila);
    } catch (e) {
      print('Erro ao buscar personagens: $vila');
    } finally {
      isLoading(false);
    }
  }
}
