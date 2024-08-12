import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste/models/models_api/model_character.dart';

// Interface para definir a estrutura dos repositórios de grupo
abstract class IGroup {
  Future<List<Character>> getGrupo(int index, {int page = 1, int limit = 45});
}

// Implementação do repositório para buscar dados dos grupos
class GrupoRepository implements IGroup {
  // Mapeia índices de grupo para URLs da API
  final Map<int, String> groupUrls = {
    0: 'https://narutodb.xyz/api/akatsuki', // URL para o grupo Akatsuki
    1: 'https://narutodb.xyz/api/tailed-beast', // URL para o grupo Tailed Beasts
    2: 'https://narutodb.xyz/api/kara', // URL para o grupo Kara
  };

  @override
  Future<List<Character>> getGrupo(int index, {int page = 1, int limit = 45}) async {
    // Obtém a URL correspondente ao índice do grupo
    final url = groupUrls[index];
    if (url == null) {
      throw Exception('Índice de grupo inválido'); // Lança exceção se o índice for inválido
    }

    // Monta a URL da requisição com parâmetros de paginação
    final requestUrl = '$url?page=$page&limit=$limit';

    try {
      // Faz a requisição HTTP para buscar os dados
      final response = await http.get(Uri.parse(requestUrl));

      // Verifica se a resposta foi bem-sucedida
      if (response.statusCode == 200) {
        // Decodifica o corpo da resposta como JSON
        final dynamic jsonBody = jsonDecode(response.body);
        List<dynamic> grupoList;

        // Dependendo do índice do grupo, extrai a lista apropriada do JSON
        switch (index) {
          case 0:
            grupoList = jsonBody['akatsuki'] ?? []; // Lista para Akatsuki
            break;
          case 1:
            grupoList = jsonBody['tailedBeasts'] ?? []; // Lista para Tailed Beasts
            break;
          case 2:
            grupoList = jsonBody['kara'] ?? []; // Lista para Kara
            break;
          default:
            throw Exception('Índice de grupo inválido'); // Lança exceção se o índice for inválido
        }

        // Filtra e mapeia os dados JSON para instâncias de Character
        List<Character> personagens = grupoList
        .where((json) =>
          json['images'] != null &&
          json['images'].isNotEmpty &&
          json['jutsu'] != null &&
          json['jutsu'].isNotEmpty &&
          json['debut'] != null &&
          (json['debut']['anime'] != null || json['debut']['manga'] != null))
        .map((json) => Character.fromJson(json)).toList();

        return personagens; // Retorna a lista de personagens
      } else if (response.statusCode == 404) {
        throw Exception('Grupo não encontrado'); // Lança exceção se o grupo não for encontrado
      } else {
        throw Exception('Erro ao buscar personagens: ${response.statusCode}'); // Lança exceção para outros erros
      }
    } catch (e) {
      print('Erro: $e'); // Imprime o erro no console
      throw e; // Lança o erro para que o chamador possa tratá-lo
    }
  }
}
