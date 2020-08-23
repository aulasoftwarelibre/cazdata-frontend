import 'package:cazdata_frontend/journey/model/journey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JourneyRepository {
  Future<JourneysList> getJourneys(String userId) async {
    JourneysList journeysList;

    try {
      final documentsQuery = await Firestore.instance
          .collection('journeys')
          .where("hunterId", isEqualTo: userId)
          .getDocuments();
      final journeyDocuments = documentsQuery.documents;
      journeysList = JourneysList.fromFirestoreDocuments(journeyDocuments);
    } catch (exception) {
      journeysList = JourneysList();
    }

    return journeysList;
  }

  Future<bool> postJourney(Journey journey, String userId) async {
    Firestore.instance
        .collection('journeys')
        .document()
        .setData({
          'hunterId': userId,
          'title': journey.title,
          'startsAt': Timestamp.fromDate(journey.startsAt),
          'endsAt': Timestamp.fromDate(journey.endsAt),
          'distance': journey.distance,
          'calories': journey.calories
        })
        .then((value) => null)
        .catchError(() => null);

    return false;
  }
}
