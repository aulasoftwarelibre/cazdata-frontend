import 'package:cazdata_frontend/features/animal-list/actions.dart';
import 'package:cazdata_frontend/features/animal-list/middleware.dart';
import 'package:cazdata_frontend/features/journey-list/actions.dart';
import 'package:cazdata_frontend/features/journey-list/middleware.dart';
import 'package:cazdata_frontend/features/login/middleware.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:redux/redux.dart';

middleware(Store<AppState> store, action, NextDispatcher next) {
  print(action.runtimeType);

  if (action is LoginAction) {
    loginMiddleware(store, action, next);
  } else if (action is AnimalAction) {
    animalMiddleware(store, action, next);
  } else if (action is JourneyListAction) {
    journeyMiddleware(store, action, next);
  }

  next(action);
}
