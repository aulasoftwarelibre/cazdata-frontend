import 'package:cazdata_frontend/features/animal-list/state.dart';
import 'package:cazdata_frontend/features/current-journey/state.dart';
import 'package:cazdata_frontend/features/journey-list/state.dart';
import 'package:cazdata_frontend/features/login/state.dart';
import 'package:flutter/material.dart';

class AppState {
  final FirebaseState firebaseState;
  final bool userIsNew;
  final AnimalsListState animalsListState;
  final CurrentJourneyState currentJourneyState;
  final HunterJourneysState hunterJourneysState;

  const AppState(
      {@required this.firebaseState,
      @required this.userIsNew,
      @required this.animalsListState,
      @required this.currentJourneyState,
      @required this.hunterJourneysState});

  factory AppState.initial() {
    return AppState(
      firebaseState: FirebaseState.initial(),
      userIsNew: false,
      animalsListState: AnimalsListState.initial(),
      currentJourneyState: CurrentJourneyState.initial(),
      hunterJourneysState: HunterJourneysState.initial(),
    );
  }

  AppState copyWith(
      {FirebaseState firebaseState,
      bool userIsNew,
      AnimalsListState animalsListState,
      CurrentJourneyState currentJourneyState,
      HunterJourneysState hunterJourneysState}) {
    return new AppState(
        firebaseState: firebaseState ?? this.firebaseState,
        userIsNew: userIsNew ?? this.userIsNew,
        animalsListState: animalsListState ?? this.animalsListState,
        currentJourneyState: currentJourneyState ?? this.currentJourneyState,
        hunterJourneysState: hunterJourneysState ?? this.hunterJourneysState);
  }
}
