import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class JourneyRepository {
  Future<JourneysList> getJourneys(String userId) async {
    JourneysList journeysList;

    try {
      final documentsQuery =
          await FirebaseFirestore.instance.collection('journeys').where('hunterId', isEqualTo: userId).get();
      final journeyDocuments = documentsQuery.docs;
      journeysList = JourneysList.fromFirestoreDocuments(journeyDocuments);
    } catch (exception) {
      journeysList = JourneysList();
    }

    return journeysList;
  }

  Future<bool> postJourney(Journey journey, String userId, List<LatLng> polylineCoordinates) async {
    FirebaseFirestore.instance
        .collection('journeys')
        .doc()
        .set({
          'hunterId': userId,
          'title': journey.title,
          'startsAt': Timestamp.fromDate(journey.startsAt),
          'endsAt': Timestamp.fromDate(journey.endsAt),
          'distance': journey.distance,
          'calories': journey.calories,
          'geopoints': polylineCoordinates.map((polyline) => GeoPoint(polyline.latitude, polyline.longitude)).toList()
        })
        .then((value) => null)
        .catchError(() => null);

    return false;
  }
}
