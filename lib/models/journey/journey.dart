import 'package:cloud_firestore/cloud_firestore.dart';

class Journey {
  String id;
  String title;
  String hunterId;
  String modality;
  String type;
  DateTime startsAt;
  DateTime endsAt;
  int distance;
  int minutes;
  int calories;
  List<GeoPoint> geopoints;

  Journey(
      {this.id,
      this.title,
      this.hunterId,
      this.modality,
      this.type,
      this.startsAt,
      this.endsAt,
      this.distance,
      this.minutes,
      this.calories,
      this.geopoints});

  Map toJson() {
    return {
      'id': this.id,
      'hunterId': this.hunterId,
      'title': this.title,
      'startsAt': this.startsAt,
      'endsAt': this.endsAt,
      'distance': this.distance,
      'calories': this.calories,
      'modality': this.modality,
      'geopoints': this
          .geopoints
          .map((GeoPoint geopoint) => {'geopoint': GeoPoint(geopoint.latitude, geopoint.longitude)})
          .toList()
    };
  }

  factory Journey.copy(Journey other) {
    return new Journey(
      id: other.id,
      title: other.title,
      hunterId: other.hunterId,
      startsAt: other.startsAt,
      endsAt: other.endsAt,
      distance: other.distance,
      calories: other.calories,
      modality: other.modality,
    );
  }

  factory Journey.fromJson(String id, Map<String, dynamic> json) {
    List<GeoPoint> geopoints =
        json['geopoints'].toList().map<GeoPoint>((e) => GeoPoint(e.latitude, e.longitude)).toList();

    return new Journey(
        id: id,
        title: json['title'],
        hunterId: json['hunterId'],
        startsAt: json['startsAt'].toDate(),
        endsAt: json['endsAt'].toDate(),
        distance: json['distance'],
        calories: json['calories'],
        modality: json['modality'],
        geopoints: geopoints);
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
