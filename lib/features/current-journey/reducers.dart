import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/features/current-journey/actions.dart';
import 'package:cazdata_frontend/features/current-journey/state.dart';
import 'package:cazdata_frontend/models/animal/hunted-animal.dart';
import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:redux/redux.dart';

CurrentJourneyState _updateAnimalsReducer(CurrentJourneyState state, UpdateAnimalsAction action) {
  List<Animal> selectedAnimals = action.animals;
  return state.copyWith(selectedAnimals: selectedAnimals);
}

CurrentJourneyState _saveCurrentJourneyReducer(CurrentJourneyState state, SaveCurrentJourneyAction action) {
  return state.copyWith(journey: action.journey);
}

CurrentJourneyState _addHuntedAnimalReducer(CurrentJourneyState state, AddHuntedAnimalAction action) {
  List<HuntedAnimal> huntedAnimals = state.journey.huntedAnimals;
  Journey journey = state.journey.copyWith(state.journey);

  huntedAnimals.add(action.huntedAnimal);

  journey.huntedAnimals = huntedAnimals;

  return state.copyWith(journey: journey);
}

CurrentJourneyState _addRouteReducer(CurrentJourneyState state, AddRouteAction action) {
  Journey journey = state.journey.copyWith(state.journey);
  journey.route = action.route;

  return state.copyWith(journey: journey);
}

CurrentJourneyState _cleanCurrentJourneyReducer(CurrentJourneyState state, CleanCurrentJourneyAction action) {
  return CurrentJourneyState.initial();
}

CurrentJourneyState _updateModality(CurrentJourneyState state, UpdateModalityAction action) {
  Journey journey = state.journey.copyWith(state.journey);
  journey.modality = action.modality;

  return state.copyWith(journey: journey);
}

Reducer<CurrentJourneyState> reduceCurrentJourneysState = combineReducers<CurrentJourneyState>([
  new TypedReducer<CurrentJourneyState, UpdateAnimalsAction>(_updateAnimalsReducer),
  new TypedReducer<CurrentJourneyState, UpdateModalityAction>(_updateModality),
  new TypedReducer<CurrentJourneyState, SaveCurrentJourneyAction>(_saveCurrentJourneyReducer),
  new TypedReducer<CurrentJourneyState, AddHuntedAnimalAction>(_addHuntedAnimalReducer),
  new TypedReducer<CurrentJourneyState, CleanCurrentJourneyAction>(_cleanCurrentJourneyReducer),
  new TypedReducer<CurrentJourneyState, AddRouteAction>(_addRouteReducer)
]);
