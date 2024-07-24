class Character {
  final int id;
  final String name;
  final List<String> images;
  final Debut debut;
  final List<String> jutsu;

  Character({
    required this.id,
    required this.name,
    required this.images,
    required this.debut,
    required this.jutsu,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      images: List<String>.from(json["images"] ?? []),
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
  final String? anime;

  Debut({
    this.manga,
    this.anime,
  });

  factory Debut.fromMap(Map<String, dynamic> json) {
    return Debut(
      manga: json["manga"] ?? "",
      anime: json["anime"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "manga": manga,
      "anime": anime,
    };
  }
}
