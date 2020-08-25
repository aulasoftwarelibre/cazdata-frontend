import 'package:cazdata_frontend/features/hunter/actions.dart';
import 'package:cazdata_frontend/features/hunter/state.dart';
import 'package:redux/redux.dart';

HunterState _loginReducer(HunterState state, HunterLoginAction action) {
  return state.copyWith(hunter: action.hunter);
}

HunterState _logoutReducer(HunterState state, HunterLogoutAction action) {
  return state.copyWith(hunter: null);
}

Reducer<HunterState> reduceHunterState = combineReducers<HunterState>([
  new TypedReducer<HunterState, HunterLoginAction>(_loginReducer),
  new TypedReducer<HunterState, HunterLogoutAction>(_logoutReducer),
]);
