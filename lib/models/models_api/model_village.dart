import 'package:teste/models/models_api/model_character.dart';

class Village {
  final int id;
  final String name;
  final List<Character> characters;

  Village({
    required this.id,
    required this.name,
    required this.characters,
  });

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      characters: (json["characters"] as List<dynamic>?)
          ?.map((charJson) => Character.fromJson(charJson))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "characters": characters.map((e) => e.toMap()).toList(),
    };
  }
}
