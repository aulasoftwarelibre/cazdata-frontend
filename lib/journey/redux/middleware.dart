import 'package:cazdata_frontend/journey/model/journey.dart';
import 'package:cazdata_frontend/journey/redux/actions.dart';
import 'package:cazdata_frontend/journey/services/journey.repository.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:redux/redux.dart';

journeyMiddleware(
    Store<AppState> store, JourneyAction action, NextDispatcher next) {
  if (action is LoadJourneysRequestAction) {
    _handleStartLoadingJourneysAction(store, action);
  }
}

_handleStartLoadingJourneysAction(
    Store<AppState> store, LoadJourneysRequestAction action) async {
  JourneyRepository journeyRepository = new JourneyRepository();
  String userId = store.state.firebaseState.firebaseUser.uid;
  JourneysList journeysList = await journeyRepository.getJourneys(userId);

  if (journeysList != null) {
    store.dispatch(LoadJourneysSuccessAction(journeysList));
  } else {
    store.dispatch(LoadJourneysFailureAction());

    Future.delayed(Duration(seconds: 2), () {
      store.dispatch(LoadJourneysRequestAction());
    });
  }
}
