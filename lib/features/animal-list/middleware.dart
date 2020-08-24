import 'package:cazdata_frontend/features/animal-list/actions.dart';
import 'package:cazdata_frontend/models/animal/animal.repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction handleLoadAnimalsAction() {
  AnimalRepository _animalRepository = new AnimalRepository();

  return (Store store) async {
    new Future(() async {
      store.dispatch(new LoadAnimalsRequestAction());
      _animalRepository.getAnimals().then((animalList) async {
        store.dispatch(new LoadAnimalsSuccessAction(animalList));
      }, onError: (error) {
        store.dispatch(new LoadAnimalsFailureAction());
        Future.delayed(Duration(seconds: 2), () {
          handleLoadAnimalsAction();
        });
      });
    });
  };
}
