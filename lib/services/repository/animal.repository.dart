import 'package:cazdata_frontend/model/animal.dart';
// import 'package:cazdata_frontend/services/networking/index.dart';
// import 'package:cazdata_frontend/util/url.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalRepository {
  // ApiProvider _provider = ApiProvider();

  Future<AnimalsList> getAnimals() async {
    AnimalsList animalsList;

    try {
      final documentsQuery =
          await Firestore.instance.collection('animals').getDocuments();
      final animalDocuments = documentsQuery.documents;
      animalsList = AnimalsList.fromJson(animalDocuments);
    } catch (exception) {}

    return animalsList;
  }
}
