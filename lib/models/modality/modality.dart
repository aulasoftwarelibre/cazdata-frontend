import 'package:cloud_firestore/cloud_firestore.dart';

class Modality {
  String id;
  String name;

  Modality({this.id, this.name});

  factory Modality.fromJson(String id, Map<String, dynamic> json) {
    return new Modality(id: id, name: json['name']);
  }
}

class ModalitiesList {
  final List<Modality> modalities;

  ModalitiesList({this.modalities});

  factory ModalitiesList.fromFirestoreDocuments(List<DocumentSnapshot> documentsList) {
    List<Modality> modalities = new List<Modality>();

    modalities = documentsList.map((document) => Modality.fromJson(document.id, document.data())).toList();

    return new ModalitiesList(modalities: modalities);
  }
}
