import 'package:cazdata_frontend/model/animal.dart';
import 'package:cazdata_frontend/redux/index.dart';

AppState mainReducer(AppState state, dynamic action) {
  FirebaseState firebaseState = _reduceFirebaseState(state, action);
  bool userIsNew = _reduceUserIsNew(state, action);
  AnimalsListState animalsListState = _reduceAnimalsListState(state, action);
  CurrentJourneyState currentJourneyState = _reduceCurrentJourneyStateState(state, action);

  return AppState(
      firebaseState: firebaseState,
      userIsNew: userIsNew,
      animalsListState: animalsListState,
      currentJourneyState: currentJourneyState
      );
}

FirebaseState _reduceFirebaseState(AppState state, dynamic action) {
  FirebaseState newState = state.firebaseState;

  if (action is UserLoadedAction) {
    newState = newState.copyWith(
        firebaseUser: action.firebaseUser, idTokenUser: action.idTokenUser);
  }
  return newState;
}

bool _reduceUserIsNew(AppState state, dynamic action) {
  bool userIsNew = state.userIsNew;

  if (action is UserIsNew) {
    userIsNew = action.userIsNew;
  }

  return userIsNew;
}

AnimalsListState _reduceAnimalsListState(AppState state, dynamic action) {
  AnimalsListState newState = state.animalsListState;

  if (action is StartLoadingAnimalsAction) {
    newState = newState.copyWith(isLoading: true, errorLoading: false);
  } else if (action is AnimalsLoadedAction) {
    newState = newState.copyWith(
        animals: action.animalsList.animals, isLoading: false);
  } else if (action is AnimalsLoadFailedAction) {
    newState = newState.copyWith(isLoading: false, errorLoading: true);
  }

  return newState;
}

CurrentJourneyState _reduceCurrentJourneyStateState(AppState state, dynamic action) {
  CurrentJourneyState newState = state.currentJourneyState;

  if (action is AddAnimalAction) {
    List<Animal> newAnimals = [];
    if(newState.animals != null){
      newAnimals = newState.animals;
    }

    newAnimals.add(action.animal);

    newState = newState.copyWith(animals: newAnimals, journey: newState.journey);
  } else if(action is RemoveAnimalAction){
    List<Animal> newAnimals = newState.animals;
    newAnimals
        .removeWhere((animal) => animal.id == action.animal.id);
    
    newState = newState.copyWith(animals: newAnimals);
  } else if(action is SaveCurrentJourney){
    newState = newState.copyWith(animals: newState.animals, journey: action.journey);
  } else if(action is CleanCurrentJourney){
    newState = newState.copyWith(journey: null, animals: null);
  }

  return newState;
}
