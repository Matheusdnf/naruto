import 'package:get/get.dart';
import 'package:teste/models/models_api/model_character.dart';
import '../repository/repository_groups.dart';

class GrupoController extends GetxController {
  // Instância do repositório de grupos
  final GrupoRepository _grupoRepository = GrupoRepository();

  // armazenar os personagens
  var personagens = <Character>[].obs;

  // mostrar o estado de carregamento
  var isLoading = true.obs;

  //  armazenar mensagens de erro
  var errorMessage = ''.obs;

  // Método para buscar personagens de um grupo
  //index se refere-se ao grupo que será requisitado as informações
  Future<void> fetchGrupo(Group gruop) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // Busca os personagens do grupo usando o repositório
      final resultado = await _grupoRepository.getGrupo(gruop);
      personagens.value = resultado;
    } catch (e) {
      errorMessage.value = 'Erro ao carregar personagens: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
