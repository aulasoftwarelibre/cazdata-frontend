import 'dart:async';

import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/widget/bottom-navigation-bar.widget.dart';
import 'package:cazdata_frontend/ui/widget/data-protection-dialog.widget.dart';
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
              if(store.state.userIsNew){
                showDialog(
                    context: context,
                    child: DataProtectionWidget(),
                    )
              }
              else{
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return MaterialApp(
                          title: 'Group',
                          theme: ThemeData(
                              primaryColor: primaryColor,
                              fontFamily: 'Montserrat'),
                          home: ChangeNotifierProvider<
                              BottomNavigationBarProvider>(
                            child: BottomNavigationBarWidget(),
                            create: (BuildContext context) =>
                                BottomNavigationBarProvider(),
                          ),
                        );
                      },
                    ),
                  )
              }                  
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
              SizedBox(height: 20.0),
              Text("Cazdata",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 74, color: accentColor)
              ),
              Image(image: AssetImage("assets/hunter.jpg"), height: 350.0,),
              Text(
                "La aplicación CazData está diseñada para\ntener un historial de tu progreso y logros\ncomo cazador. Mira tu historial de jornadas\ny compártelo con la comunidad.",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.0),
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
