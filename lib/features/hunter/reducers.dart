import 'package:cazdata_frontend/features/hunter/actions.dart';
import 'package:cazdata_frontend/features/hunter/state.dart';
import 'package:redux/redux.dart';

HunterState _requestReducer(HunterState state, LoginWithGoogleSuccessAction action) {
  return state.copyWith(hunter: action.hunter);
}

HunterState _userIsNewReducer(HunterState state, HunterIsNewAction action) {
  return state.copyWith(isNew: action.userIsNew);
}

Reducer<HunterState> reduceHunterState = combineReducers<HunterState>([
  new TypedReducer<HunterState, LoginWithGoogleSuccessAction>(_requestReducer),
  new TypedReducer<HunterState, HunterIsNewAction>(_userIsNewReducer)
]);