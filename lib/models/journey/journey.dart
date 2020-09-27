import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/models/animal/hunted-animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Journey {
  String id;
  String title;
  String hunterId;
  String modality;
  String type;
  DateTime startsAt;
  DateTime endsAt;
  int numberOfHunters;
  int distance;
  int minutes;
  int calories;
  List<GeoPoint> geopoints;
  List<HuntedAnimal> huntedAnimals;

  Journey({
    this.id,
    this.title,
    this.hunterId,
    this.modality,
    this.type,
    this.startsAt,
    this.endsAt,
    this.numberOfHunters,
    this.distance,
    this.minutes,
    this.calories,
    this.geopoints,
    this.huntedAnimals,
  });

  factory Journey.copy(Journey other) {
    return new Journey(
      id: other.id,
      title: other.title,
      hunterId: other.hunterId,
      startsAt: other.startsAt,
      endsAt: other.endsAt,
      numberOfHunters: other.numberOfHunters,
      distance: other.distance,
      calories: other.calories,
      modality: other.modality,
    );
  }

  factory Journey.fromJson(String id, Map<String, dynamic> json) {
    List<GeoPoint> geopoints =
        json['geopoints'].toList().map<GeoPoint>((e) => GeoPoint(e.latitude, e.longitude)).toList();

    List<HuntedAnimal> huntedAnimals = json['huntedAnimals'].toList().map<HuntedAnimal>((e) {
      return HuntedAnimal(animal: Animal(name: e['name'], contentUrl: e['photo']));
    }).toList();

    return new Journey(
      id: id,
      title: json['title'],
      hunterId: json['hunterId'],
      startsAt: json['startsAt'].toDate(),
      endsAt: json['endsAt'].toDate(),
      numberOfHunters: json['numberOfHunters'],
      distance: json['distance'],
      calories: json['calories'],
      modality: json['modality'],
      geopoints: geopoints,
      huntedAnimals: huntedAnimals,
    );
  }
}

class JourneysList {
  final List<Journey> journeys;

  JourneysList({this.journeys});

  factory JourneysList.fromFirestoreDocuments(List<DocumentSnapshot> documentsList) {
    List<Journey> journeys = new List<Journey>();

    journeys = documentsList.map((document) => Journey.fromJson(document.id, document.data())).toList();

    return new JourneysList(journeys: journeys);
  }
}
