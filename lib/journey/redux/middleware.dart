import 'package:cazdata_frontend/journey/model/journey.dart';
import 'package:cazdata_frontend/journey/redux/actions.dart';
import 'package:cazdata_frontend/journey/services/journey.repository.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/util/keys.dart';
import 'package:cazdata_frontend/util/routes.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

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

ThunkAction postCurrentJourneyAction(Journey journey, String userId) {
  JourneyRepository _journeyRepository = new JourneyRepository();

  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartSendingJourneyAction());
      _journeyRepository.postJourney(journey, userId).then((journey) async {
        store.dispatch(new SendingJourneySuccessAction());
        Keys.navKey.currentState.pushNamed(Routes.homePage);
      }, onError: (error) {
        store.dispatch(new SendingJourneyFailedAction());
      });
    });
  };
}
