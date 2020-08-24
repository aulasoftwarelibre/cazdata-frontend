import 'package:cazdata_frontend/redux/index.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

Store<AppState> createStore() {
  return Store(
    mainReducer,
    middleware: createMiddleware(),
    initialState: AppState.initial(),
  );
}

List<Middleware<AppState>> createMiddleware() => <Middleware<AppState>>[thunkMiddleware, middleware];
