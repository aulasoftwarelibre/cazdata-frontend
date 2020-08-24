import 'package:cazdata_frontend/features/hunter/actions.dart';
import 'package:cazdata_frontend/features/login/actions.dart';
import 'package:cazdata_frontend/models/hunter/hunter.dart';
import 'package:cazdata_frontend/models/hunter/hunter.repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction createHunterAction(Hunter hunter) {
  HunterRepository _hunterRepository = new HunterRepository();

  return (Store store) async {
    new Future(() async {
      store.dispatch(new CreateHunterRequestAction());
      _hunterRepository.createHunter(hunter).then((hunter) async {
        store.dispatch(new CreateHunterSuccessAction());
        store.dispatch(new UserIsNewAction(false));
      }, onError: (error) {
        store.dispatch(new CreateHunterFailureAction());
      });
    });
  };
}
