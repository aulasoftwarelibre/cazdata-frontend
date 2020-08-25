import 'package:cazdata_frontend/models/hunter/hunter.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/widget/bottom-navigation-bar.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        builder: (BuildContext context, _ViewModel vm) => _homeView(context, vm),
        converter: (store) => _ViewModel.fromStore(store));
  }

  Widget _homeView(BuildContext context, _ViewModel vm) {
    if (vm.hunter == null) {
      return CircularProgressIndicator();
    }

    return ChangeNotifierProvider<BottomNavigationBarProvider>(
      child: BottomNavigationBarWidget(),
      create: (BuildContext context) => BottomNavigationBarProvider(),
    );
  }
}

class _ViewModel {
  final Hunter hunter;

  _ViewModel({@required this.hunter});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(hunter: store.state.hunterState.hunter);
  }
}
