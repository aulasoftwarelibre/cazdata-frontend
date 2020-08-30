import 'package:cazdata_frontend/features/animal-list/reducers.dart';
import 'package:cazdata_frontend/features/animal-list/state.dart';
import 'package:cazdata_frontend/features/current-journey/reducers.dart';
import 'package:cazdata_frontend/features/hunter/reducers.dart';
import 'package:cazdata_frontend/features/current-journey/state.dart';
import 'package:cazdata_frontend/features/hunter/state.dart';
import 'package:cazdata_frontend/features/modalities-list/reducers.dart';
import 'package:cazdata_frontend/features/modalities-list/state.dart';
import 'package:cazdata_frontend/redux/index.dart';

AppState mainReducer(AppState state, dynamic action) {
  HunterState hunterState = reduceHunterState(state.hunterState, action);
  AnimalsListState animalsListState = reduceAnimalsListState(state.animalsListState, action);
  CurrentJourneyState currentJourneyState = reduceCurrentJourneysState(state.currentJourneyState, action);
  ModalitiesListState modalitiesListState = reduceModalitiesListState(state.modalitiesListState, action);

  return AppState(
      hunterState: hunterState,
      animalsListState: animalsListState,
      currentJourneyState: currentJourneyState,
      modalitiesListState: modalitiesListState);
}
