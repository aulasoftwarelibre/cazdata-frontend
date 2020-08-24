import 'package:cazdata_frontend/features/animal-list/actions.dart';
import 'package:cazdata_frontend/features/animal-list/state.dart';
import 'package:cazdata_frontend/redux/index.dart';

AnimalsListState reduceAnimalsListState(AppState state, dynamic action) {
  AnimalsListState newState = state.animalsListState;

  if (action is LoadAnimalsRequestAction) {
    newState = newState.copyWith(isLoading: true, errorLoading: false);
  } else if (action is LoadAnimalsSuccessAction) {
    newState = newState.copyWith(animals: action.animalsList.animals, isLoading: false);
  } else if (action is LoadAnimalsFailureAction) {
    newState = newState.copyWith(isLoading: false, errorLoading: true);
  }

  return newState;
}
