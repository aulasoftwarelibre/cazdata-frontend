import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/pages/login.dart';
import 'package:cazdata_frontend/ui/widget/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel(
          user: store.state.firebaseState.firebaseUser,
          logout: () {
            store.dispatch(LogoutAction());
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return LoginPage();
            }), ModalRoute.withName('/'));
          }),
      builder: (BuildContext context, _ViewModel vm) =>
          _profileView(context, vm),
    );
  }

  Widget _profileView(BuildContext context, _ViewModel vm) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CazData'),
      ),
      body: DefaultTextStyle(
        style: TextStyle(
            inherit: true,
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'Montserrat',
            decoration: TextDecoration.none,
            decorationColor: Colors.black,
            decorationStyle: TextDecorationStyle.solid,
            color: Colors.black),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Cuenta',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: FlatButton(
                        onPressed: (){
                          vm.logout();
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0)),
                        child: Text("Cerrar sesión",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                  child: Text(
                    'Perfil',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                ProfileWidget(
                    name: vm.user.displayName,
                    location: vm.user.email,
                    profilePic: vm.user.photoUrl),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                  child: TextFieldWidget(
                      header: 'Nivel Cazador', content: 'Novato (10)'),
                ),
                TextFieldWidget(
                    header: 'Descripción',
                    content:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final FirebaseUser user;
  final Function() logout;

  _ViewModel({
    @required this.user,
    @required this.logout,
  });
}
