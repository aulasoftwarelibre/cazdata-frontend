import 'package:cazdata_frontend/features/login/actions.dart';
import 'package:cazdata_frontend/features/login/state.dart';
import 'package:redux/redux.dart';

LoginState _loginIsNewReducer(LoginState state, LoginIsNewAction action) {
  return state.copyWith(isNew: action.userIsNew);
}

LoginState _autologinRequestReducer(LoginState state, AutoLoginRequestAction action) {
  return state.copyWith(isLogged: false);
}

LoginState _autologinSuccessReducer(LoginState state, AutoLoginSuccessAction action) {
  return state.copyWith(isLogged: true);
}

LoginState _logoutReducer(LoginState state, LogoutRequestAction action) {
  return state.copyWith(isLogged: false);
}

Reducer<LoginState> reduceLoginState = combineReducers<LoginState>([
  new TypedReducer<LoginState, LoginIsNewAction>(_loginIsNewReducer),
  new TypedReducer<LoginState, AutoLoginRequestAction>(_autologinRequestReducer),
  new TypedReducer<LoginState, AutoLoginSuccessAction>(_autologinSuccessReducer),
  new TypedReducer<LoginState, LogoutRequestAction>(_logoutReducer),
]);
