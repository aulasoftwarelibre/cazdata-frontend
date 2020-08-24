import 'package:cazdata_frontend/features/animal-list/reducers.dart';
import 'package:cazdata_frontend/features/animal-list/state.dart';
import 'package:cazdata_frontend/features/current-journey/reducers.dart';
import 'package:cazdata_frontend/features/journey-list/reducers.dart';
import 'package:cazdata_frontend/features/current-journey/state.dart';
import 'package:cazdata_frontend/features/journey-list/state.dart';
import 'package:cazdata_frontend/features/login/reducers.dart';
import 'package:cazdata_frontend/features/login/state.dart';
import 'package:cazdata_frontend/redux/index.dart';

AppState mainReducer(AppState state, dynamic action) {
  FirebaseState firebaseState = reduceFirebaseState(state, action);
  bool userIsNew = reduceUserIsNew(state, action);
  AnimalsListState animalsListState = reduceAnimalsListState(state.animalsListState, action);
  CurrentJourneyState currentJourneyState = reduceCurrentJourneysState(state.currentJourneyState, action);
  HunterJourneysState hunterJourneysState = reduceHunterJourneysState(state.hunterJourneysState, action);

  return AppState(
      firebaseState: firebaseState,
      userIsNew: userIsNew,
      animalsListState: animalsListState,
      currentJourneyState: currentJourneyState,
      hunterJourneysState: hunterJourneysState);
}
