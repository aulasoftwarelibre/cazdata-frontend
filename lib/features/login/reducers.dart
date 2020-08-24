import 'package:cazdata_frontend/features/login/state.dart';
import 'package:cazdata_frontend/redux/index.dart';

FirebaseState reduceFirebaseState(AppState state, dynamic action) {
  FirebaseState newState = state.firebaseState;

  if (action is UserLoadedAction) {
    newState = newState.copyWith(firebaseUser: action.firebaseUser, idTokenUser: action.idTokenUser);
  }
  return newState;
}

bool reduceUserIsNew(AppState state, dynamic action) {
  bool userIsNew = state.userIsNew;

  if (action is UserIsNewAction) {
    userIsNew = action.userIsNew;
  }

  return userIsNew;
}
