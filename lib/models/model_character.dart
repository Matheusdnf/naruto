class Character {
  final int id;
  final String name;
  final List<String> images;
  final Debut debut;
  final List<String> jutsu;
  final List<String> teams;
  final List<String> group;

  Character({
    required this.id,
    required this.name,
    required this.images,
    required this.debut,
    required this.jutsu,
    this.teams = const [],
    this.group = const [],
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      images: List<String>.from(json["images"] ?? []),
      debut: Debut.fromMap(json["debut"] ?? {}),
      jutsu: List<String>.from(json["jutsu"] ?? []),
      teams: _parseList(json["personal"]?["team"]),
      group: _parseList(json["personal"]?["affiliation"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "images": List<dynamic>.from(images.map((x) => x)),
      "debut": debut.toMap(),
      "jutsu": List<dynamic>.from(jutsu.map((x) => x)),
      "personal": {
        "team": List<dynamic>.from(teams.map((x) => x)),
        "affiliation": List<dynamic>.from(group.map((x) => x)),
      },
    };
  }

  static List<String> _parseList(dynamic value) {
    if (value is List) {
      return List<String>.from(value);
    } else if (value is String) {
      return [value];
    }
    return [];
  }
}

class Debut {
  final String anime;
  final String manga;

  Debut({
    required this.anime,
    required this.manga,
  });

  factory Debut.fromMap(Map<String, dynamic> json) {
    return Debut(
      anime: json["anime"] ?? "",
      manga: json["manga"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "anime": anime,
      "manga": manga,
    };
  }
}
