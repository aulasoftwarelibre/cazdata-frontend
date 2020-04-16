
import 'package:cazdata_frontend/redux/index.dart';
import 'package:redux/redux.dart';

Store<AppState> createStore() {
  return Store(
    mainReducer,
    middleware: createMiddleware(),
    initialState: AppState.initial(),
  );
}

List<Middleware<AppState>> createMiddleware() => <Middleware<AppState>>[
      middleware
    ];