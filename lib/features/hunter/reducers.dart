import 'package:cazdata_frontend/features/hunter/state.dart';
import 'package:cazdata_frontend/features/login/actions.dart';
import 'package:redux/redux.dart';

HunterState _requestReducer(HunterState state, LoginWithGoogleSuccessAction action) {
  return state.copyWith(hunter: action.hunter);
}

Reducer<HunterState> reduceHunterState = combineReducers<HunterState>([
  new TypedReducer<HunterState, LoginWithGoogleSuccessAction>(_requestReducer),
]);
