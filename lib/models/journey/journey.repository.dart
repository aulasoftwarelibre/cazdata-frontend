import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JourneyRepository {
  Future<JourneysList> getJourneys(String userId) async {
    JourneysList journeysList;

    try {
      final documentsQuery = await FirebaseFirestore.instance
          .collection('journeys')
          .where('hunterId', isEqualTo: userId)
          .orderBy('endsAt', descending: true)
          .get();
      final journeyDocuments = documentsQuery.docs;
      journeysList = JourneysList.fromFirestoreDocuments(journeyDocuments);
    } catch (exception) {
      journeysList = JourneysList();
    }

    return journeysList;
  }

  Future<bool> postJourney(Journey journey, List<Animal> selectedAnimals, String userId) async {
    FirebaseFirestore.instance
        .collection('journeys')
        .doc()
        .set({
          'hunterId': userId,
          'title': journey.title,
          'startsAt': Timestamp.fromDate(journey.startsAt),
          'endsAt': Timestamp.fromDate(journey.endsAt),
          'numberOfHunters': journey.numberOfHunters,
          'distance': journey.distance,
          'minutes': journey.minutes,
          'calories': journey.calories,
          'modality': journey.modality,
          'selectedAnimals': selectedAnimals.map((selectedAnimal) => selectedAnimal.name).toList(),
          'huntedAnimals': journey.huntedAnimals
              .map((huntedAnimal) => {
                    "id": huntedAnimal.animal.id,
                    "name": huntedAnimal.animal.name,
                    "photo": huntedAnimal.animal.contentUrl,
                    "position": GeoPoint(huntedAnimal.position.latitude, huntedAnimal.position.longitude)
                  })
              .toList(),
          'route': journey.route
        })
        .then((value) => null)
        .catchError(() => null);

    return false;
  }
}
