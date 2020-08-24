import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/features/current-journey/actions.dart';
import 'package:cazdata_frontend/features/current-journey/state.dart';
import 'package:cazdata_frontend/models/animal/hunted-animal.dart';
import 'package:redux/redux.dart';

CurrentJourneyState _updateAnimalsReducer(CurrentJourneyState state, UpdateAnimalsAction action) {
  List<Animal> newAnimals = action.animals;
  return state.copyWith(selectedAnimals: newAnimals);
}

CurrentJourneyState _saveCurrentJourneyReducer(CurrentJourneyState state, SaveCurrentJourneyAction action) {
  return state.copyWith(journey: action.journey);
}

CurrentJourneyState _addHuntedAnimalReducer(CurrentJourneyState state, AddHuntedAnimalAction action) {
  List<HuntedAnimal> newHuntedAnimals = state.huntedAnimals;

  newHuntedAnimals.add((action.huntedAnimal));
  return state.copyWith(huntedAnimals: newHuntedAnimals);
}

CurrentJourneyState _cleanCurrentJourneyReducer(CurrentJourneyState state, CleanCurrentJourneyAction action) {
  return state.copyWith(journey: null, selectedAnimals: null, huntedAnimals: null, polylineCoordinates: null);
}

Reducer<CurrentJourneyState> reduceCurrentJourneysState = combineReducers<CurrentJourneyState>([
  new TypedReducer<CurrentJourneyState, UpdateAnimalsAction>(_updateAnimalsReducer),
  new TypedReducer<CurrentJourneyState, SaveCurrentJourneyAction>(_saveCurrentJourneyReducer),
  new TypedReducer<CurrentJourneyState, AddHuntedAnimalAction>(_addHuntedAnimalReducer),
  new TypedReducer<CurrentJourneyState, CleanCurrentJourneyAction>(_cleanCurrentJourneyReducer)
]);
