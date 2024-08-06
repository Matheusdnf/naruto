import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste/models/model_character.dart';

abstract class IPersonal {
  Future<List<Character>> getPersonal(int index);
}

class Personalreposity implements IPersonal {
  @override
  //lista com os filtros dos grupos
  // final List<String> _filter_group = [
  // final String 'Konohagakure';
  // final String 'Allied Shinobi Forces';
  // final String 'Akatsuki';
  // ];

  //lista com os filtros dos teams
  // final List<String> _filter_teams = [
  // final String 'Team 7';
  // final String 'Kakashi';
  // ];
  Future<List<Character>> getPersonal(int index) async {
    final url = 'https://narutodb.xyz/api/character';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final dynamic jsonBody = jsonDecode(response.body);
        final List<dynamic> vilaList = jsonBody['characters'] ?? [];
        List<Character> personagens = vilaList
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
        throw Exception("Não encontrado");
      } else {
        throw Exception('Erro ao buscar personagens');
      }
    } catch (e) {
      print('Erro: $e');
      throw e;
    }
  }
}
