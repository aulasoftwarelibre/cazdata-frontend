import 'package:cazdata_frontend/features/hunter/middleware.dart';
import 'package:cazdata_frontend/features/login/actions.dart';
import 'package:cazdata_frontend/models/hunter/hunter.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/util/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

loginMiddleware(Store<AppState> store, LoginAction action, NextDispatcher next) {
  if (action is LoginWithGoogleRequestAction) {
    _handleLoginWithGoogleAction(store, action, next);
  }
}

_handleLoginWithGoogleAction(Store<AppState> store, LoginWithGoogleRequestAction action, NextDispatcher next) async {
  FirebaseUser user = await _auth.currentUser();

  GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  user = authResult.user;

  Hunter hunter = Hunter.fromFirebaseUser(user);

  if (authResult.additionalUserInfo.isNewUser) {
    store.dispatch(LoginIsNewAction(true));
    next(LoginIsNewAction);

    store.dispatch(createHunterAction(hunter));
  }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  store.dispatch(LoginWithGoogleSuccessAction(hunter));

  action.completer.complete();
}

ThunkAction<AppState> handleAutoLoginAction(BuildContext context) {
  return (Store<AppState> store) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    new Future(() async {
      store.dispatch(AutoLoginRequestAction());
      FirebaseUser user = await _auth.currentUser();
      if (user is FirebaseUser) {
        store.dispatch(AutoLoginSuccessAction());
        store.dispatch(LoginWithGoogleSuccessAction(Hunter.fromFirebaseUser(user)));

        //Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationBarWidget()));

        Navigator.pushNamed(context, homeRoute);

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return ChangeNotifierProvider<BottomNavigationBarProvider>(
        //         child: BottomNavigationBarWidget(),
        //         create: (BuildContext context) => BottomNavigationBarProvider(),
        //       );
        //     },
        //   ),
        // );
      }
    });
  };
}

ThunkAction<AppState> handleLogoutAction(BuildContext context) {
  return (Store<AppState> store) async {
    new Future(() async {
      store.dispatch(LogoutRequestAction());
      await _googleSignIn.signOut();
      await _auth.signOut();
    });
  };
}
