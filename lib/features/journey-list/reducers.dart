import 'package:cazdata_frontend/features/journey-list/actions.dart';
import 'package:cazdata_frontend/features/journey-list/state.dart';
import 'package:redux/redux.dart';

HunterJourneysState _requestReducer(HunterJourneysState state, LoadJourneysRequestAction action) {
  return state.copyWith(isLoading: true, errorLoading: false);
}

HunterJourneysState _successReducer(HunterJourneysState state, LoadJourneysSuccessAction action) {
  return state.copyWith(journeysList: action.journeysList, isLoading: false);
}

HunterJourneysState _failureReducer(HunterJourneysState state, LoadJourneysFailureAction action) {
  return state.copyWith(isLoading: false, errorLoading: true);
}

Reducer<HunterJourneysState> reduceHunterJourneysState = combineReducers<HunterJourneysState>([
  new TypedReducer<HunterJourneysState, LoadJourneysRequestAction>(_requestReducer),
  new TypedReducer<HunterJourneysState, LoadJourneysSuccessAction>(_successReducer),
  new TypedReducer<HunterJourneysState, LoadJourneysFailureAction>(_failureReducer)
]);
