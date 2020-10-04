import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:flutter/material.dart';

@immutable
class CurrentJourneyState {
  final Journey journey;
  final List<Animal> selectedAnimals;

  const CurrentJourneyState({@required this.journey, @required this.selectedAnimals});

  factory CurrentJourneyState.initial() {
    return new CurrentJourneyState(journey: Journey.initial(), selectedAnimals: []);
  }

  CurrentJourneyState copyWith({Journey journey, List<Animal> selectedAnimals}) {
    return new CurrentJourneyState(
        journey: journey ?? this.journey, selectedAnimals: selectedAnimals ?? this.selectedAnimals);
  }
}
