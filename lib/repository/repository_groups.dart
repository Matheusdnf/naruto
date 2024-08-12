import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste/models/models_api/model_character.dart';

abstract class IGroup {
  Future<List<Character>> getGrupo(Group group , {int page = 1, int limit = 45});
}

enum Group {
  akatsuki,
  tailedBeast,
  kara,
}

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

    try {
      final response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
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
            throw Exception('Índice de grupo inválido');
        }

        List<Character> personagens = grupoList
            .where((json) =>
                json['images'] != null &&
                json['images'].isNotEmpty &&
                json['jutsu'] != null &&
                json['jutsu'].isNotEmpty &&
                json['debut'] != null &&
                (json['debut']['anime'] != null || json['debut']['manga'] != null))
            .map((json) => Character.fromJson(json))
            .toList();

        return personagens;
      } else if (response.statusCode == 404) {
        throw Exception('Grupo não encontrado');
      } else {
        throw Exception('Erro ao buscar personagens: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
      throw e;
    }
  }
}