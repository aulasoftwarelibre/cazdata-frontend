
import 'package:cazdata_frontend/model/animal.dart';
import 'package:cazdata_frontend/redux/index.dart';

AppState mainReducer(AppState state, dynamic action) {
  FirebaseState firebaseState = _reduceFirebaseState(state, action);
  bool userIsNew = _reduceUserIsNew(state, action);
  AnimalsList animalsList = _reduceAnimalsList(state, action);

  return AppState(firebaseState: firebaseState, userIsNew: userIsNew, animalsList: animalsList);
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

  if (action is UserIsNew) {
    userIsNew = action.userIsNew;
  }

  return userIsNew;
}

AnimalsList _reduceAnimalsList(AppState state, dynamic action){
  AnimalsList animalsList = state.animalsList;

  if(action is AnimalsLoadedAction) {
    animalsList = action.animalsList;
  }

  return animalsList;
}
