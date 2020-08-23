import 'package:cazdata_frontend/animal/redux/reducer.dart';
import 'package:cazdata_frontend/animal/redux/state.dart';
import 'package:cazdata_frontend/journey/redux/reducer.dart';
import 'package:cazdata_frontend/journey/redux/state.dart';
import 'package:cazdata_frontend/redux/index.dart';

AppState mainReducer(AppState state, dynamic action) {
  FirebaseState firebaseState = _reduceFirebaseState(state, action);
  bool userIsNew = _reduceUserIsNew(state, action);
  AnimalsListState animalsListState = reduceAnimalsListState(state, action);
  CurrentJourneyState currentJourneyState =
      reduceCurrentJourneyStateState(state, action);
  HunterJourneysState hunterJourneysState =
      reduceHunterJourneysState(state.hunterJourneysState, action);

  return AppState(
      firebaseState: firebaseState,
      userIsNew: userIsNew,
      animalsListState: animalsListState,
      currentJourneyState: currentJourneyState,
      hunterJourneysState: hunterJourneysState);
}

FirebaseState _reduceFirebaseState(AppState state, dynamic action) {
  FirebaseState newState = state.firebaseState;

  if (action is UserLoadedAction) {
    newState = newState.copyWith(
        firebaseUser: action.firebaseUser, idTokenUser: action.idTokenUser);
  }
  return newState;
}

bool _reduceUserIsNew(AppState state, dynamic action) {
  bool userIsNew = state.userIsNew;

  if (action is UserIsNewAction) {
    userIsNew = action.userIsNew;
  }

  return userIsNew;
}
