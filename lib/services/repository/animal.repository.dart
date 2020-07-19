import 'package:cazdata_frontend/model/animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalRepository {
  Future<AnimalsList> getAnimals() async {
    AnimalsList animalsList;

    try {
      final documentsQuery =
          await Firestore.instance.collection('animals').getDocuments();
      final animalDocuments = documentsQuery.documents;
      animalsList = AnimalsList.fromFirestoreDocuments(animalDocuments);
    } catch (exception) {}

    return animalsList;
  }
}
