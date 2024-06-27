// Classe dos Caracter
class Caracter {
  final int id;
  final String name;
  // Agora é uma lista de Strings para as URLs das imagens
  final List<String> images;
  // Lista de Strings para os jutsus
  final Debut debut;
  final List<String> jutsu;

  Caracter({
    required this.id,
    required this.name,
    required this.images,
    required this.debut,
    required this.jutsu,
  });
// Transformando o JSON para um tipo de dado que o Dart entende
  factory Caracter.fromjson(Map<String, dynamic> json) {
    return Caracter(
      //esses '?' são utilizados pois na api eles podem retornar nulos
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      images: List<String>.from(json["images"] ?? []),
      //aqui o debut é um dicionário
      debut: Debut.fromMap(json["debut"] ?? {}),
      jutsu: List<String>.from(json["jutsu"] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "images": List<dynamic>.from(images.map((x) => x)),
      "debut": debut.toMap(),
      "jutsu": List<dynamic>.from(jutsu.map((x) => x)),
    };
  }
}

class Debut {
  final String? manga;
  final String? movie;

  Debut({
    this.manga,
    this.movie,
  });

  factory Debut.fromMap(Map<String, dynamic> json) {
    return Debut(
      manga: json["manga"] ?? "",
      movie: json["movie"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "manga": manga,
      "movie": movie,
    };
  }
}
