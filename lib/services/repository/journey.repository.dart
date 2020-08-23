import 'dart:convert';

import 'package:cazdata_frontend/model/journey.dart';
import 'package:cazdata_frontend/services/networking/index.dart';
import 'package:cazdata_frontend/util/url.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JourneyRepository {
  Future<JourneysList> getJourneys() async {
    JourneysList journeysList;

    try {
      final documentsQuery =
          await Firestore.instance.collection('journeys').getDocuments();
      final journeyDocuments = documentsQuery.documents;
      journeysList = JourneysList.fromFirestoreDocuments(journeyDocuments);
    } catch (exception) {}

    return journeysList;
  }

  Future<bool> postJourney(Journey journey, String tokenId) async {
    await Firestore.instance
        .collection('journeys')
        .document()
        .setData({
          'hunterId': journey.hunterId,
          'title': journey.title,
          'startsAt': Timestamp.fromDate(journey.startsAt),
          'endsAt': Timestamp.fromDate(journey.endsAt),
          'distance': journey.distance,
          'calories': journey.calories
        })
        .then((value) => null)
        .catchError(() => null);

    return true;
  }
}
