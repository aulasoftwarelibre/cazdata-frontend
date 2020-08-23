import 'package:cazdata_frontend/animal/redux/actions.dart';
import 'package:cazdata_frontend/animal/redux/state.dart';
import 'package:cazdata_frontend/redux/index.dart';

AnimalsListState reduceAnimalsListState(AppState state, dynamic action) {
  AnimalsListState newState = state.animalsListState;

  if (action is LoadAnimalsRequestAction) {
    newState = newState.copyWith(isLoading: true, errorLoading: false);
  } else if (action is LoadAnimalsSuccessAction) {
    newState = newState.copyWith(
        animals: action.animalsList.animals, isLoading: false);
  } else if (action is LoadAnimalsFailureAction) {
    newState = newState.copyWith(isLoading: false, errorLoading: true);
  }

  return newState;
}