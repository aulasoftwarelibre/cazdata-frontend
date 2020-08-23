import 'package:cazdata_frontend/model/animal.dart';
import 'package:cazdata_frontend/model/hunted-animal.dart';
import 'package:cazdata_frontend/journey/model/journey.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
class HunterJourneysState {
  final JourneysList journeysList;
  final bool isLoading;
  final bool errorLoading;

  const HunterJourneysState(
      {@required this.journeysList,
      @required this.isLoading,
      @required this.errorLoading});

  factory HunterJourneysState.initial() {
    return new HunterJourneysState(
        journeysList: new JourneysList(),
        isLoading: false,
        errorLoading: false);
  }

  HunterJourneysState copyWith(
      {JourneysList journeysList, bool isLoading, bool errorLoading}) {
    return new HunterJourneysState(
        journeysList: journeysList ?? this.journeysList,
        isLoading: isLoading ?? this.isLoading,
        errorLoading: errorLoading ?? this.errorLoading);
  }
}

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
    return new CurrentJourneyState(
        journey: null,
        selectedAnimals: [],
        huntedAnimals: [],
        polylineCoordinates: []);
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
