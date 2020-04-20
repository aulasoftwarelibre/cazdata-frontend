import 'dart:async';


import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/widget/bottom-navigation-bar.widget.dart';
import 'package:cazdata_frontend/ui/widget/oauth-login-button.widget.dart';
import 'package:cazdata_frontend/util/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(converter: (store) {
      return new _ViewModel(
          user: store.state.firebaseState.firebaseUser,
          login: () {
            final result = LoginWithGoogleAction();

            store.dispatch(result);

            Future.wait([result.completer.future]).then((user) => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return MaterialApp(
                          title: 'Group',
                          theme: ThemeData(
                              primaryColor: primaryColor,
                              fontFamily: 'Montserrat'),
                          home: ChangeNotifierProvider<BottomNavigationBarProvider>(
                            child: BottomNavigationBarWidget(),
                            create: (BuildContext context) => BottomNavigationBarProvider(),
                          ),
                        );
                      },
                    ),
                  )
                });
          });
    }, builder: (BuildContext context, _ViewModel vm) {
      return _loginView(context, vm);
    });
  }

  Widget _loginView(BuildContext context, _ViewModel vm) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OAuthLoginButton(
                onPressed: vm.login,
                text: "Inicia Sesión con Google",
                assetName: "assets/google_logo.png",
                backgroundColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final FirebaseUser user;
  final Function() login;

  _ViewModel({
    @required this.user,
    @required this.login,
  });
}
