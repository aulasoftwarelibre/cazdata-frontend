import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/features/current-journey/actions.dart';
import 'package:cazdata_frontend/features/current-journey/state.dart';
import 'package:cazdata_frontend/models/animal/hunted-animal.dart';
import 'package:cazdata_frontend/redux/index.dart';

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
