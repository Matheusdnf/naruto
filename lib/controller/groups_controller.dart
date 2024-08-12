import 'package:get/get.dart';
import 'package:teste/models/models_api/model_character.dart';
import '../repository/repository_groups.dart';

class GrupoController extends GetxController {
  // Instância do repositório de grupos
  final GrupoRepository _grupoRepository = GrupoRepository();

  // RxList para armazenar os personagens
  var personagens = <Character>[].obs;

  // RxBool para mostrar o estado de carregamento
  var isLoading = true.obs;

  // RxString para armazenar mensagens de erro
  var errorMessage = ''.obs;

  // Método para buscar personagens de um grupo
  Future<void> fetchGrupo(int index) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Busca os personagens do grupo usando o repositório
      final resultado = await _grupoRepository.getGrupo(index);
      personagens.value = resultado;
    } catch (e) {
      errorMessage.value = 'Erro ao carregar personagens: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
