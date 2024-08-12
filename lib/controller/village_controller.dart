import 'package:get/get.dart';
import 'package:teste/models/models_api/model_character.dart';
import 'package:teste/repository/repository_village.dart';

class VillageController extends GetxController {
  //Nomes das Vilas
  var villages = <String>[].obs;
  //
  var isLoading = true.obs;
  //Observar A mudança do personagems
  var vila = <Character>[].obs;
  //Observar o id da vila
  var selectedVillageId = 0.obs;

  final Vilareposity vilareposity = Vilareposity(); // Instância do repositório

  @override
  void onInit() {
    super.onInit();
    //iniciarlizar os  valores (Nomes) das vilas
    villages.value = [
      'Konohagakure',
      'Sunagakure',
      'Kirigakure',
      'Iwagakure',
      'Kumogakure',
    ];
    isLoading.value = false;
  }
  //pegar os personagens
  //villageId é para filtrar os persoangens pelo id da vida 
  void fetchCharacter(int villageId) async {
    try {
      isLoading(true);
      //id da vila selecionado para filtrar os personagens
      selectedVillageId.value = villageId;
      //Lista de personagens pegados
      final List<Character> fetchedVila = await vilareposity.getVila(villageId);
      vila.assignAll(fetchedVila);
    } catch (e) {
      print('Erro ao buscar personagens: $vila');
    } finally {
      isLoading(false);
    }
  }
}
