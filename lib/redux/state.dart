import 'package:cazdata_frontend/features/animal-list/state.dart';
import 'package:cazdata_frontend/features/current-journey/state.dart';
import 'package:cazdata_frontend/features/hunter/state.dart';
import 'package:flutter/material.dart';

class AppState {
  final HunterState hunterState;
  final AnimalsListState animalsListState;
  final CurrentJourneyState currentJourneyState;

  const AppState({
    @required this.hunterState,
    @required this.animalsListState,
    @required this.currentJourneyState,
  });

  factory AppState.initial() {
    return AppState(
      hunterState: HunterState.initial(),
      animalsListState: AnimalsListState.initial(),
      currentJourneyState: CurrentJourneyState.initial(),
    );
  }

  AppState copyWith({
    HunterState hunterState,
    bool userIsNew,
    AnimalsListState animalsListState,
    CurrentJourneyState currentJourneyState,
  }) {
    return new AppState(
      hunterState: hunterState ?? this.hunterState,
      animalsListState: animalsListState ?? this.animalsListState,
      currentJourneyState: currentJourneyState ?? this.currentJourneyState,
    );
  }
}
