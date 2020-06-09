class AnimalsList {
  final List<Animal> animals;

  AnimalsList({this.animals});

  factory AnimalsList.fromJson(List<dynamic> parsedJson) {
    List<Animal> animals = new List<Animal>();
    animals = parsedJson.map((i) => Animal.fromJson(i)).toList();

    return new AnimalsList(animals: animals);
  }
}

class Animal {
  String id;
  String name;
  bool isEnabled;
  String type;
  String contentUrl;

  Animal({this.id, this.name, this.isEnabled, this.type, this.contentUrl});

  Map toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'isEnabled': this.isEnabled,
      'type': this.type,
      'contentUrl': this.contentUrl
    };
  }

  factory Animal.fromJson(Map<String, dynamic> json) {
    return new Animal(
        id: json['id'],
        name: json['name'],
        isEnabled: json['isEnabled'],
        type: json['type'],
        contentUrl: json['contentUrl']);
  }
}
