import 'package:cazdata_frontend/features/animal-list/state.dart';
import 'package:cazdata_frontend/features/current-journey/state.dart';
import 'package:cazdata_frontend/features/journey-list/state.dart';
import 'package:cazdata_frontend/features/hunter/state.dart';
import 'package:cazdata_frontend/features/login/state.dart';
import 'package:flutter/material.dart';

class AppState {
  final HunterState hunterState;
  final AnimalsListState animalsListState;
  final CurrentJourneyState currentJourneyState;
  final HunterJourneysState hunterJourneysState;
  final LoginState loginState;

  const AppState(
      {@required this.hunterState,
      @required this.animalsListState,
      @required this.currentJourneyState,
      @required this.hunterJourneysState,
      @required this.loginState});

  factory AppState.initial() {
    return AppState(
        hunterState: HunterState.initial(),
        animalsListState: AnimalsListState.initial(),
        currentJourneyState: CurrentJourneyState.initial(),
        hunterJourneysState: HunterJourneysState.initial(),
        loginState: LoginState.initial());
  }

  AppState copyWith(
      {HunterState hunterState,
      bool userIsNew,
      AnimalsListState animalsListState,
      CurrentJourneyState currentJourneyState,
      HunterJourneysState hunterJourneysState,
      LoginState loginState}) {
    return new AppState(
        hunterState: hunterState ?? this.hunterState,
        animalsListState: animalsListState ?? this.animalsListState,
        currentJourneyState: currentJourneyState ?? this.currentJourneyState,
        hunterJourneysState: hunterJourneysState ?? this.hunterJourneysState,
        loginState: loginState ?? this.loginState);
  }
}
