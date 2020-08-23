import 'package:cazdata_frontend/animal/model/animal.dart';
import 'package:cazdata_frontend/journey/redux/actions.dart';
import 'package:cazdata_frontend/journey/redux/state.dart';
import 'package:cazdata_frontend/animal/model/hunted-animal.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:redux/redux.dart';

HunterJourneysState requestReducer(HunterJourneysState state, LoadJourneysRequestAction action) {
  return state.copyWith(isLoading: true, errorLoading: false);
}

HunterJourneysState successReducer(HunterJourneysState state, LoadJourneysSuccessAction action) {
  return state.copyWith(journeysList: action.journeysList, isLoading: false);
}

HunterJourneysState failureReducer(HunterJourneysState state, LoadJourneysFailureAction action) {
  return state.copyWith(isLoading: false, errorLoading: true);
}

Reducer<HunterJourneysState> reduceHunterJourneysState = combineReducers<HunterJourneysState>([
  new TypedReducer<HunterJourneysState, LoadJourneysRequestAction>(requestReducer),
  new TypedReducer<HunterJourneysState, LoadJourneysSuccessAction>(successReducer),
  new TypedReducer<HunterJourneysState, LoadJourneysFailureAction>(failureReducer)
]);

CurrentJourneyState reduceCurrentJourneyStateState(AppState state, dynamic action) {
  CurrentJourneyState newState = state.currentJourneyState;

  if (action is UpdateAnimalsAction) {
    List<Animal> newAnimals = action.animals;

    newState = newState.copyWith(selectedAnimals: newAnimals);
  } else if (action is SaveCurrentJourneyAction) {
    newState = newState.copyWith(journey: action.journey);
  } else if (action is AddHuntedAnimalAction) {
    List<HuntedAnimal> newHuntedAnimals = state.currentJourneyState.huntedAnimals;

    newHuntedAnimals.add((action.huntedAnimal));
    newState = newState.copyWith(huntedAnimals: newHuntedAnimals);
  } else if (action is CleanCurrentJourneyAction) {
    newState = newState.copyWith(journey: null, selectedAnimals: null, huntedAnimals: null, polylineCoordinates: null);
  }

  return newState;
}
