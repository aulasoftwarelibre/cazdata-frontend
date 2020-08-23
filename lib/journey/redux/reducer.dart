import 'package:cazdata_frontend/animal/model/animal.dart';
import 'package:cazdata_frontend/journey/redux/actions.dart';
import 'package:cazdata_frontend/journey/redux/state.dart';
import 'package:cazdata_frontend/animal/model/hunted-animal.dart';
import 'package:cazdata_frontend/redux/index.dart';

HunterJourneysState reduceHunterJourneysState(AppState state, dynamic action) {
  HunterJourneysState newState = state.hunterJourneysState;

  if (action is LoadJourneysRequestAction) {
    newState = newState.copyWith(isLoading: true, errorLoading: false);
  } else if (action is LoadJourneysSuccessAction) {
    newState =
        newState.copyWith(journeysList: action.journeysList, isLoading: false);
  } else if (action is LoadJourneysFailureAction) {
    newState = newState.copyWith(isLoading: false, errorLoading: true);
  }

  return newState;
}

CurrentJourneyState reduceCurrentJourneyStateState(
    AppState state, dynamic action) {
  CurrentJourneyState newState = state.currentJourneyState;

  if (action is UpdateAnimalsAction) {
    List<Animal> newAnimals = action.animals;

    newState = newState.copyWith(selectedAnimals: newAnimals);
  } else if (action is SaveCurrentJourneyAction) {
    newState = newState.copyWith(journey: action.journey);
  } else if (action is AddHuntedAnimalAction) {
    List<HuntedAnimal> newHuntedAnimals =
        state.currentJourneyState.huntedAnimals;

    newHuntedAnimals.add((action.huntedAnimal));
    newState = newState.copyWith(huntedAnimals: newHuntedAnimals);
  } else if (action is CleanCurrentJourneyAction) {
    newState = newState.copyWith(
        journey: null,
        selectedAnimals: null,
        huntedAnimals: null,
        polylineCoordinates: null);
  }

  return newState;
}
