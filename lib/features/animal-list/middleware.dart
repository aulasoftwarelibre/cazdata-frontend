import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/features/animal-list/actions.dart';
import 'package:cazdata_frontend/models/animal/animal.repository.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:redux/redux.dart';

animalMiddleware(Store<AppState> store, AnimalAction action, NextDispatcher next) {
  if (action is LoadAnimalsRequestAction) {
    _handleLoadAnimalsAction(store, action);
  }
}

_handleLoadAnimalsAction(Store<AppState> store, LoadAnimalsRequestAction action) async {
  AnimalRepository animalRepository = new AnimalRepository();
  AnimalsList animalsList = await animalRepository.getAnimals();

  if (animalsList != null) {
    store.dispatch(LoadAnimalsSuccessAction(animalsList));
  } else {
    store.dispatch(LoadAnimalsFailureAction());

    Future.delayed(Duration(seconds: 2), () {
      store.dispatch(LoadAnimalsRequestAction());
    });
  }
}
