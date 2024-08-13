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

  // Método para buscar personagens de um grupo
  //index se refere-se ao grupo que será requisitado as informações
Future<void> fetchGrupo(Group grupo) async {
  //o try e o catch são usado para capturar o erro, e assim evitar que fique em loop infinito de loading
  isLoading.value = true;
  try {
    // Busca os personagens do grupo usando o repositório
    final resultado = await _grupoRepository.getGrupo(grupo);
    personagens.value = resultado;
    //erro capturado
  } catch (e) {
    // print("esse é o erro${e}");
    // Se houver um erro, atualize a mensagem de erro
  //erro ao capturar os personagens
  } finally {
    // Garante que o estado de carregamento é atualizado
    isLoading.value = false;
    }
  }
}
