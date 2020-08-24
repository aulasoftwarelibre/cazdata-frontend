import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/models/animal/hunted-animal.dart';
import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
class CurrentJourneyState {
  final Journey journey;
  final List<Animal> selectedAnimals;
  final List<HuntedAnimal> huntedAnimals;
  final List<LatLng> polylineCoordinates;

  const CurrentJourneyState(
      {@required this.journey,
      @required this.selectedAnimals,
      @required this.huntedAnimals,
      @required this.polylineCoordinates});

  factory CurrentJourneyState.initial() {
    return new CurrentJourneyState(journey: null, selectedAnimals: [], huntedAnimals: [], polylineCoordinates: []);
  }

  CurrentJourneyState copyWith(
      {Journey journey,
      List<Animal> selectedAnimals,
      List<HuntedAnimal> huntedAnimals,
      List<LatLng> polylineCoordinates}) {
    return new CurrentJourneyState(
        journey: journey ?? this.journey,
        selectedAnimals: selectedAnimals ?? this.selectedAnimals,
        huntedAnimals: huntedAnimals ?? this.huntedAnimals,
        polylineCoordinates: polylineCoordinates ?? this.polylineCoordinates);
  }
}
