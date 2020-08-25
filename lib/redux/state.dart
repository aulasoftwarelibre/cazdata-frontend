import 'package:cazdata_frontend/features/animal-list/state.dart';
import 'package:cazdata_frontend/features/current-journey/state.dart';
import 'package:cazdata_frontend/features/journey-list/state.dart';
import 'package:cazdata_frontend/features/hunter/state.dart';
import 'package:flutter/material.dart';

class AppState {
  final HunterState hunterState;
  final AnimalsListState animalsListState;
  final CurrentJourneyState currentJourneyState;
  final HunterJourneysState hunterJourneysState;

  const AppState({
    @required this.hunterState,
    @required this.animalsListState,
    @required this.currentJourneyState,
    @required this.hunterJourneysState,
  });

  factory AppState.initial() {
    return AppState(
        hunterState: HunterState.initial(),
        animalsListState: AnimalsListState.initial(),
        currentJourneyState: CurrentJourneyState.initial(),
        hunterJourneysState: HunterJourneysState.initial());
  }

  AppState copyWith({
    HunterState hunterState,
    bool userIsNew,
    AnimalsListState animalsListState,
    CurrentJourneyState currentJourneyState,
    HunterJourneysState hunterJourneysState,
  }) {
    return new AppState(
        hunterState: hunterState ?? this.hunterState,
        animalsListState: animalsListState ?? this.animalsListState,
        currentJourneyState: currentJourneyState ?? this.currentJourneyState,
        hunterJourneysState: hunterJourneysState ?? this.hunterJourneysState);
  }
}
