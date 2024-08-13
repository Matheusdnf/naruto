import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste/models/models_api/model_character.dart';

// Interface para definir a estrutura dos repositórios de grupo
abstract class IGroup {
  Future<List<Character>> getGrupo(Group group , {int page = 1, int limit = 45});
}

enum Group {
  akatsuki,
  tailedBeast,
  kara,
}

// Implementação do repositório para buscar dados dos grupos
class GrupoRepository implements IGroup {
  //os grupos que serão carregados 
  final Map<Enum, String> groupUrls = {
    Group.akatsuki: 'https://narutodb.xyz/api/akatsuki',
    Group.tailedBeast:'https://narutodb.xyz/api/tailed-beast',
    Group.kara:'https://narutodb.xyz/api/kara',
  };


  @override
  Future<List<Character>> getGrupo(Group group, {int page = 1, int limit = 45}) async {
    final url = groupUrls[group];

    final requestUrl = '$url?page=$page&limit=$limit';

      // Faz a requisição HTTP para buscar os dados
      final response = await http.get(Uri.parse(requestUrl));

      // Verifica se a resposta foi bem-sucedida
      if (response.statusCode == 200) {
        // Decodifica o corpo da resposta como JSON
        final dynamic jsonBody = jsonDecode(response.body);
        List<dynamic> grupoList;

        switch (group) {
          case Group.akatsuki:
            grupoList = jsonBody['akatsuki'] ?? [];
            break;
          case Group.tailedBeast:
            grupoList = jsonBody['tailedBeasts'] ?? [];
            break;
          case Group.kara:
            grupoList = jsonBody['kara'] ?? [];
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
    }
  }
