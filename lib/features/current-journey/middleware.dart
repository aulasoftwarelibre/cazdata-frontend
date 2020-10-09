import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:cazdata_frontend/features/current-journey/actions.dart';
import 'package:cazdata_frontend/models/journey/journey.repository.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> postCurrentJourneyAction(BuildContext context) {
  JourneyRepository _journeyRepository = new JourneyRepository();

  return (Store<AppState> store) async {
    final Journey journey = store.state.currentJourneyState.journey;
    final List<Animal> seletedAnimals = store.state.currentJourneyState.selectedAnimals;
    final String hunterId = store.state.hunterState.hunter.id;

    new Future(() async {
      store.dispatch(new SendJourneyRequestAction());
      _journeyRepository.postJourney(journey, seletedAnimals, hunterId).then((journey) async {
        store.dispatch(new SendJourneySuccessAction());
      }, onError: (error) {
        store.dispatch(new SendJourneyFailureAction());
      });
    });
  };
}
