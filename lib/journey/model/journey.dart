import 'package:cloud_firestore/cloud_firestore.dart';

class JourneysList {
  final List<Journey> journeys;

  JourneysList({this.journeys});

  factory JourneysList.fromFirestoreDocuments(
      List<DocumentSnapshot> documentsList) {
    List<Journey> journeys = new List<Journey>();

    journeys = documentsList
        .map((document) => Journey.fromJson(document.documentID, document.data))
        .toList();

    return new JourneysList(journeys: journeys);
  }
}

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
      this.calories});

  Map toJson() {
    return {
      'id': this.id,
      'hunterId': this.hunterId,
      'title': this.title,
      'startsAt': this.startsAt,
      'endsAt': this.endsAt,
      'distance': this.distance,
      'calories': calories
    };
  }

  factory Journey.fromJson(String id, Map<String, dynamic> json) {
    return new Journey(
      id: id,
      title: json['title'],
      hunterId: json['hunterId'],
      startsAt: json['startsAt'].toDate(),
      endsAt: json['endsAt'].toDate(),
      distance: json['distance'],
      calories: json['calories'],
    );
  }
}
