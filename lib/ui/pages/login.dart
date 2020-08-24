import 'dart:async';

import 'package:cazdata_frontend/features/login/actions.dart';
import 'package:cazdata_frontend/features/login/middleware.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/widget/bottom-navigation-bar.widget.dart';
import 'package:cazdata_frontend/ui/widget/data-protection-dialog.widget.dart';
import 'package:cazdata_frontend/ui/widget/oauth-login-button.widget.dart';
import 'package:cazdata_frontend/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(onInit: (store) {
      store.dispatch(handleAutoLoginAction(context));
    }, converter: (store) {
      return new _ViewModel(login: () {
        final result = LoginWithGoogleRequestAction();

        store.dispatch(result);

        Future.wait([result.completer.future]).then((user) => {
              if (store.state.loginState.isNew)
                {
                  showDialog(
                    context: context,
                    child: DataProtectionWidget(),
                  )
                }
              else
                {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ChangeNotifierProvider<BottomNavigationBarProvider>(
                          child: BottomNavigationBarWidget(),
                          create: (BuildContext context) => BottomNavigationBarProvider(),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Cazdata", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 74, color: accentColor)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage("assets/hunter.jpg"),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.ltr,
                children: [
                  Text(
                    "La aplicación CazData está diseñada para\ntener un historial de tu progreso y logros\ncomo cazador. Mira tu historial de jornadas\ny compártelo con la comunidad.",
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OAuthLoginButton(
                    onPressed: vm.login,
                    text: "Inicia Sesión con Google",
                    assetName: "assets/google_logo.png",
                    backgroundColor: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final Function() login;

  _ViewModel({
    @required this.login,
  });
}
