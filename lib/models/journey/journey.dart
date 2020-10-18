import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/models/animal/hunted-animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Journey {
  String id;
  String title;
  String hunterId;
  String modality;
  DateTime startsAt;
  DateTime endsAt;
  int numberOfHunters;
  int distance;
  int minutes;
  int calories;
  List<GeoPoint> route;
  List<HuntedAnimal> huntedAnimals;

  Journey({
    this.id,
    this.title,
    this.hunterId,
    this.modality,
    this.startsAt,
    this.endsAt,
    this.numberOfHunters,
    this.distance,
    this.minutes,
    this.calories,
    this.route,
    this.huntedAnimals,
  });

  factory Journey.initial() {
    return new Journey(
        id: null,
        title: null,
        hunterId: null,
        modality: null,
        startsAt: DateTime.now(),
        endsAt: DateTime.now(),
        numberOfHunters: 1,
        distance: 0,
        minutes: 0,
        calories: 0,
        route: [],
        huntedAnimals: []);
  }

  Journey copyWith(Journey journey) {
    return new Journey(
        id: journey.id ?? this.id,
        title: journey.title ?? this.title,
        hunterId: journey.hunterId ?? this.hunterId,
        modality: journey.modality ?? this.modality,
        startsAt: journey.startsAt ?? this.startsAt,
        endsAt: journey.endsAt ?? this.endsAt,
        numberOfHunters: journey.numberOfHunters ?? this.numberOfHunters,
        distance: journey.distance ?? this.distance,
        minutes: journey.minutes ?? this.minutes,
        calories: journey.calories ?? this.calories,
        route: journey.route ?? this.route,
        huntedAnimals: journey.huntedAnimals ?? this.huntedAnimals);
  }

  factory Journey.fromJson(String id, Map<String, dynamic> json) {
    List<GeoPoint> route = json['route'].toList().map<GeoPoint>((e) => GeoPoint(e.latitude, e.longitude)).toList();

    List<HuntedAnimal> huntedAnimals = json['huntedAnimals'].toList().map<HuntedAnimal>((animal) {
      return HuntedAnimal(animal: Animal(id: id, name: animal['name'], contentUrl: animal['photo']));
    }).toList();

    return new Journey(
      id: id,
      title: json['title'],
      hunterId: json['hunterId'],
      startsAt: json['startsAt'].toDate(),
      endsAt: json['endsAt'].toDate(),
      numberOfHunters: json['numberOfHunters'],
      distance: json['distance'],
      minutes: json['minutes'],
      calories: json['calories'],
      modality: json['modality'],
      route: route,
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
