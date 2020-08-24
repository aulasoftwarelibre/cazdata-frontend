import 'package:cazdata_frontend/features/login/actions.dart';
import 'package:cazdata_frontend/features/login/middleware.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:redux/redux.dart';

middleware(Store<AppState> store, action, NextDispatcher next) {
  print(action.runtimeType);

  if (action is LoginAction) {
    loginMiddleware(store, action, next);
  }

  next(action);
}
