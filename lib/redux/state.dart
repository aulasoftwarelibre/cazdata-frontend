import 'package:cazdata_frontend/features/animal-list/state.dart';
import 'package:cazdata_frontend/features/current-journey/state.dart';
import 'package:cazdata_frontend/features/journey-list/state.dart';
import 'package:cazdata_frontend/features/login/state.dart';
import 'package:flutter/material.dart';

class AppState {
  final LoginState loginState;
  final AnimalsListState animalsListState;
  final CurrentJourneyState currentJourneyState;
  final HunterJourneysState hunterJourneysState;

  const AppState(
      {@required this.loginState,
      @required this.animalsListState,
      @required this.currentJourneyState,
      @required this.hunterJourneysState});

  factory AppState.initial() {
    return AppState(
      loginState: LoginState.initial(),
      animalsListState: AnimalsListState.initial(),
      currentJourneyState: CurrentJourneyState.initial(),
      hunterJourneysState: HunterJourneysState.initial(),
    );
  }

  AppState copyWith(
      {LoginState loginState,
      bool userIsNew,
      AnimalsListState animalsListState,
      CurrentJourneyState currentJourneyState,
      HunterJourneysState hunterJourneysState}) {
    return new AppState(
        loginState: loginState ?? this.loginState,
        animalsListState: animalsListState ?? this.animalsListState,
        currentJourneyState: currentJourneyState ?? this.currentJourneyState,
        hunterJourneysState: hunterJourneysState ?? this.hunterJourneysState);
  }
}
