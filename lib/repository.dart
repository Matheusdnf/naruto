import 'dart:convert';
import 'package:teste/models/model_caracter.dart';
import 'package:http/http.dart' as http;

abstract class Ipersonagemreposity {
  Future<List<Caracter>> getCaracter(int page); // (int page) Atualizamos o método para aceitar um número de página dinâmico. A URL da API agora é construída com base no número da página e no limite de itens por página.
}

class Caracterreposity implements Ipersonagemreposity {
  @override
  Future<List<Caracter>> getCaracter(int page) async {
    const limit = 20; // Limite de personagens requeridos
    final url = 'https://narutodb.xyz/api/character?page=$page&limit=$limit';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Decodifica o JSON
      final dynamic jsonBody = jsonDecode(response.body);
      final List<dynamic> characterList = jsonBody['characters'];
      // Mapeia cada objeto dentro da lista para um objeto Caracter usando Caracter.fromjson
      List<Caracter> characters =
          characterList.map((json) => Caracter.fromjson(json)).toList();
      return characters;
    } else if (response.statusCode == 404) {
      throw Exception("Não encontrado");
    } else {
      throw Exception('Falha ao carregar os personagens');
    }
  }
}
