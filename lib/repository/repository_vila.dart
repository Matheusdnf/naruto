import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste/models/model_vila.dart';

abstract class IVilareposity {
  Future<List<Vila>> getVila(int escolha);
}

class Vilareposity implements IVilareposity {
  @override
  Future<List<Vila>> getVila(int escolha) async {
    final url = 'https://narutodb.xyz/api/village/$escolha';

    try {
      final response = await http.get(Uri.parse(url));

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic jsonBody = jsonDecode(response.body);
        final List<dynamic> vilaList = jsonBody['characters'] ?? [];
        List<Vila> vila = vilaList.map((json) => Vila.fromJson(json)).toList();
        return vila;
      } else if (response.statusCode == 404) {
        throw Exception("Não encontrado");
      } else {
        throw Exception('Falha ao carregar os personagens');
      }
    } catch (e) {
      print('Erro na requisição: $e');
      throw e;
    }
  }
}
