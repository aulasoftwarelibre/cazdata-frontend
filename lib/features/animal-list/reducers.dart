import 'package:cazdata_frontend/features/animal-list/actions.dart';
import 'package:cazdata_frontend/features/animal-list/state.dart';
import 'package:redux/redux.dart';

AnimalsListState _requestReducer(AnimalsListState state, LoadAnimalsRequestAction action) {
  return state.copyWith(isLoading: true, errorLoading: false);
}

AnimalsListState _successReducer(AnimalsListState state, LoadAnimalsSuccessAction action) {
  return state.copyWith(isLoading: false, animals: action.animalsList.animals);
}

AnimalsListState _failureReducer(AnimalsListState state, LoadAnimalsFailureAction action) {
  return state.copyWith(isLoading: false, errorLoading: true);
}

Reducer<AnimalsListState> reduceAnimalsListState = combineReducers<AnimalsListState>([
  new TypedReducer<AnimalsListState, LoadAnimalsRequestAction>(_requestReducer),
  new TypedReducer<AnimalsListState, LoadAnimalsSuccessAction>(_successReducer),
  new TypedReducer<AnimalsListState, LoadAnimalsFailureAction>(_failureReducer)
]);
