import 'package:cazdata_frontend/features/modalities-list/actions.dart';
import 'package:cazdata_frontend/features/modalities-list/state.dart';
import 'package:redux/redux.dart';

ModalitiesListState _requestReducer(ModalitiesListState state, LoadModalitiesRequestAction action) {
  return state.copyWith(isLoading: true, errorLoading: false);
}

ModalitiesListState _successReducer(ModalitiesListState state, LoadModalitiesSuccessAction action) {
  return state.copyWith(isLoading: false, modalities: action.modalitiesList.modalities);
}

ModalitiesListState _failureReducer(ModalitiesListState state, LoadModalitiesFailureAction action) {
  return state.copyWith(isLoading: false, errorLoading: true);
}

Reducer<ModalitiesListState> reduceModalitiesListState = combineReducers<ModalitiesListState>([
  new TypedReducer<ModalitiesListState, LoadModalitiesRequestAction>(_requestReducer),
  new TypedReducer<ModalitiesListState, LoadModalitiesSuccessAction>(_successReducer),
  new TypedReducer<ModalitiesListState, LoadModalitiesFailureAction>(_failureReducer),
]);
