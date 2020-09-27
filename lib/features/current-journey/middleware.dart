import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/models/animal/hunted-animal.dart';
import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:cazdata_frontend/features/current-journey/actions.dart';
import 'package:cazdata_frontend/models/journey/journey.repository.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> postCurrentJourneyAction(BuildContext context) {
  JourneyRepository _journeyRepository = new JourneyRepository();

  return (Store<AppState> store) async {
    final Journey journey = store.state.currentJourneyState.journey;
    final List<Animal> seletedAnimals = store.state.currentJourneyState.selectedAnimals;
    final List<HuntedAnimal> huntedAnimals = store.state.currentJourneyState.huntedAnimals;
    final List<LatLng> polylineCoordinates = store.state.currentJourneyState.polylineCoordinates;
    final String hunterId = store.state.hunterState.hunter.id;

    new Future(() async {
      store.dispatch(new SendJourneyRequestAction());
      _journeyRepository.postJourney(journey, seletedAnimals, huntedAnimals, hunterId, polylineCoordinates).then(
          (journey) async {
        store.dispatch(new SendJourneySuccessAction());
        Navigator.pushNamed(context, Routes.home);
      }, onError: (error) {
        store.dispatch(new SendJourneyFailureAction());
      });
    });
  };
}
