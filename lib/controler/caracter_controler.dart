import 'package:get/get.dart';
import 'package:teste/models/model_caracter.dart';
import 'package:teste/repository.dart';

class CaracterController extends GetxController {
  RxList<Caracter> characters = <Caracter>[].obs;
  RxBool isLoading = true.obs;
  var page = 1.obs; // Número da página atual.


  CaracterController(Caracterreposity caracterreposity);

  @override
  void onInit() { // Método que é chamado quando o controlador é inicializado. Aqui, chamamos fetchCharacters para buscar a primeira página de personagens.
    super.onInit();
    fetchCharacters();
  }

  void fetchCharacters() async {
    try {
      isLoading(true);

      isLoading.value = true;

      final List<Caracter> newCharacters = await Caracterreposity().getCaracter(page.value);
      characters.addAll(newCharacters); // Novos personagens requeridos
      page.value++; // Próxima página
      print(
          'Characters loaded: ${characters.length}'); // Adicione este log para verificar o número de personagens carregados
    } catch (e) {
      print(
          'Error fetching characters: $e'); // Adicione este log para verificar o erro
    } finally {
      isLoading(false);
    }
  }
}
