import 'package:cazdata_frontend/features/journey-list/actions.dart';
import 'package:cazdata_frontend/models/journey/journey.repository.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> handleLoadJourneysAction() {
  JourneyRepository _journeyRepository = new JourneyRepository();

  return (Store<AppState> store) async {
    new Future(() async {
      store.dispatch(LoadJourneysRequestAction());
      _journeyRepository.getJourneys(store.state.loginState.firebaseUser.uid).then((journeysList) async {
        store.dispatch(new LoadJourneysSuccessAction(journeysList));
      }, onError: (error) {
        store.dispatch(new LoadJourneysFailureAction());
        Future.delayed(Duration(seconds: 2), () {
          handleLoadJourneysAction();
        });
      });
    });
  };
}
