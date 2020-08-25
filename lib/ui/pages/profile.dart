import 'package:cazdata_frontend/features/hunter/middleware.dart';
import 'package:cazdata_frontend/models/hunter/hunter.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel(
          hunter: store.state.hunterState.hunter,
          logout: () {
            store.dispatch(handleLogoutAction(context));
          }),
      builder: (BuildContext context, _ViewModel vm) => _profileView(context, vm),
    );
  }

  Widget _profileView(BuildContext context, _ViewModel vm) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: PageScrollPhysics(),
          child: DefaultTextStyle(
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
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 12.0),
                      child: Text(
                        'Perfil',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    ProfileWidget(
                        name: vm.hunter.displayName, location: vm.hunter.email, profilePic: vm.hunter.photoUrl),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                      child: TextFieldWidget(header: 'Nivel Cazador', content: 'Novato (10)'),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: FlatButton(
                            onPressed: () {
                              vm.logout();
                            },
                            color: Colors.red,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(18.0)),
                            child: Text("Cerrar sesión", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final Hunter hunter;
  final Function() logout;

  _ViewModel({
    @required this.hunter,
    @required this.logout,
  });
}
