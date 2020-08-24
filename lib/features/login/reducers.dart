import 'package:cazdata_frontend/features/login/state.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:redux/redux.dart';

LoginState _requestReducer(LoginState state, LoginWithGoogleSuccessAction action) {
  return state.copyWith(firebaseUser: action.firebaseUser);
}

LoginState _userIsNewReducer(LoginState state, UserIsNewAction action) {
  return state.copyWith(isNew: action.userIsNew);
}

Reducer<LoginState> reduceLoginState = combineReducers<LoginState>([
  new TypedReducer<LoginState, LoginWithGoogleSuccessAction>(_requestReducer),
  new TypedReducer<LoginState, UserIsNewAction>(_userIsNewReducer)
]);
