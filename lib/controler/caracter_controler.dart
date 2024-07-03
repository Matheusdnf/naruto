import 'package:get/get.dart';
import 'package:teste/models/model_caracter.dart';
import 'package:teste/repository/repository.dart';

class CaracterController extends GetxController {
  RxList<Caracter> characters = <Caracter>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCharacters();
  }

  void fetchCharacters() async {
    try {
      isLoading(true);
      final List<Caracter> fetchedCharacters =
          await Caracterreposity().getCaracter();
      characters.assignAll(fetchedCharacters);
    } catch (e) {
      print(
          'Error fetching characters: $e'); // Adicione este log para verificar o erro
    } finally {
      isLoading(false);
    }
  }
}
