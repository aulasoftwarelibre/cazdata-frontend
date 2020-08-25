import 'package:cazdata_frontend/redux/index.dart';
import 'package:redux/redux.dart';

middleware(Store<AppState> store, action, NextDispatcher next) {
  print(action.runtimeType);

  next(action);
}
