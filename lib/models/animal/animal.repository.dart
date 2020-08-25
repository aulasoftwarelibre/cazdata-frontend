import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalRepository {
  Future<AnimalsList> getAnimals() async {
    AnimalsList animalsList;

    try {
      final documentsQuery = await FirebaseFirestore.instance.collection('animals').get();
      final animalDocuments = documentsQuery.docs;
      animalsList = AnimalsList.fromFirestoreDocuments(animalDocuments);
    } catch (exception) {}

    return animalsList;
  }
}
