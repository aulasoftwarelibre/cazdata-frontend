import 'package:cazdata_frontend/model/hunter.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/services/repository/hunter.repository.dart';
import 'package:cazdata_frontend/ui/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  var currentTab = [
    History(),
    Home(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      onInit: (store) {
        /*if (store.state.userIsNew == true) {
          HunterRepository hunterRepository = new HunterRepository();

          Hunter hunter = new Hunter();
          hunter.id = store.state.firebaseState.firebaseUser.uid;
          hunter.displayName =
              store.state.firebaseState.firebaseUser.displayName;
          hunter.email = store.state.firebaseState.firebaseUser.email;
          hunter.photoUrl = store.state.firebaseState.firebaseUser.photoUrl;
          hunter.isEmailVerified = true;

          hunterRepository.createHunter(
              hunter, store.state.firebaseState.idTokenUser);

          store.dispatch(UserIsNew(false));
        }*/
      },
      builder: (BuildContext context, _ViewModel viewModel) {
        return _appView(context, viewModel);
      },
      converter: (Store store) {
        return new _ViewModel();
      },
    );
  }

  Widget _appView(BuildContext context, _ViewModel viewModel) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      body: IndexedStack(
        index: provider.currentIndex,
        children: currentTab,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Historial'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Inicio'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Cuenta'),
          ),
        ],
      ),
    );
  }
}

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class _ViewModel {}
