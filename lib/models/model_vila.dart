import 'package:teste/models/model_caracter.dart';

class Vila {
  final int id;
  final String name;
  final List<Caracter> personagem;

  Vila({
    required this.id,
    required this.name,
    required this.personagem,
  });

  factory Vila.fromJson(Map<String, dynamic> json) {
    return Vila(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      personagem: (json["characters"] as List<dynamic>?)
          ?.map((charJson) => Caracter.fromJson(charJson))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "characters": personagem.map((e) => e.toMap()).toList(),
    };
  }
}
