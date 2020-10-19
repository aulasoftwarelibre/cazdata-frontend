import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalsList {
  final List<Animal> animals;

  AnimalsList({this.animals});

  factory AnimalsList.fromFirestoreDocuments(List<DocumentSnapshot> documentsList) {
    List<Animal> animals = new List<Animal>();

    animals = documentsList.map((document) => Animal.fromJson(document.id, document.data())).toList();
    return new AnimalsList(animals: animals);
  }
}

class Animal {
  String id;
  String name;
  bool isEnabled;
  String type;
  String contentUrl;
  String attribution;

  Animal({this.id, this.name, this.isEnabled, this.type, this.contentUrl, this.attribution});

  Map toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'isEnabled': this.isEnabled,
      'type': this.type,
      'contentUrl': this.contentUrl,
      'attribution': this.attribution
    };
  }

  factory Animal.fromJson(String id, Map<String, dynamic> json) {
    return new Animal(
        id: id,
        name: json['name'],
        isEnabled: json['isEnabled'],
        type: json['type'],
        contentUrl: json['image']['src'],
        attribution: json['attribution']);
  }
}
