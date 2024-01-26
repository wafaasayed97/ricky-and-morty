class Results {
  Info? info;
  List<Character>? results; // Use Character instead of Results here

  Results({this.info, this.results});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      info: json['info'] != null ? Info.fromJson(json['info']) : null,
      results: json['results'] != null
          ? List<Character>.from((json['results'] as List).map((v) => Character.fromJson(v)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (info != null) {
      data['info'] = info!.toJson();
    }
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  int? count;
  int? pages;
  String? next;
  Null prev;

  Info({this.count, this.pages, this.next, this.prev});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = count;
    data['pages'] = pages;
    data['next'] = next;
    data['prev'] = prev;
    return data;
  }
}

class Character {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  Origin? origin; // Use Origin instead of a direct object
  Origin? location; // Use Origin instead of a direct object
  String? image;
  List<String>? episode;
  String? url;
  String? created;

  Character({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: json['origin'] != null ? Origin.fromJson(json['origin']) : null,
      location: json['location'] != null ? Origin.fromJson(json['location']) : null,
      image: json['image'],
      episode: json['episode'] != null ? List<String>.from(json['episode']) : null,
      url: json['url'],
      created: json['created'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['species'] = species;
    data['type'] = type;
    data['gender'] = gender;
    if (origin != null) {
      data['origin'] = origin!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['image'] = image;
    data['episode'] = episode;
    data['url'] = url;
    data['created'] = created;
    return data;
  }
}

class Origin {
  String? name;
  String? url;

  Origin({this.name, this.url});

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['url'] = url;
    return data;
  }}