import 'package:cazdata_frontend/features/modalities-list/actions.dart';
import 'package:cazdata_frontend/models/modality/modality.repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction handleLoadModalitiesAction() {
  ModalityRepository _modalityRepository = new ModalityRepository();

  return (Store store) async {
    new Future(() async {
      store.dispatch(new LoadModalitiesRequestAction());
      _modalityRepository.getModalities().then((modalitiesList) async {
        store.dispatch(new LoadModalitiesSuccessAction(modalitiesList));
      }, onError: (error) {
        store.dispatch(new LoadModalitiesFailureAction());
        Future.delayed(Duration(seconds: 2), () {
          handleLoadModalitiesAction();
        });
      });
    });
  };
}
