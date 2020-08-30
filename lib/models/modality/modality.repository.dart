import 'package:cazdata_frontend/models/modality/modality.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ModalityRepository {
  Future<ModalitiesList> getModalities() async {
    ModalitiesList modalitiesList;

    try {
      final documentsQuery = await FirebaseFirestore.instance.collection('modalities').get();
      final modalitiesDocuments = documentsQuery.docs;
      modalitiesList = ModalitiesList.fromFirestoreDocuments(modalitiesDocuments);
    } catch (exception) {
      modalitiesList = ModalitiesList();
    }

    return modalitiesList;
  }
}
