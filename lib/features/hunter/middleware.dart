import 'package:cazdata_frontend/features/hunter/actions.dart';
import 'package:cazdata_frontend/models/hunter/hunter.dart';
import 'package:cazdata_frontend/models/hunter/hunter.repository.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/util/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

ThunkAction handleLoginWithGoogleAction(BuildContext context) {
  return (Store store) async {
    new Future(() async {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      User user = authResult.user;

      Hunter hunter = Hunter.fromFirebaseUser(user);

      store.dispatch(createHunterAction(hunter));

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      assert(user.uid == _auth.currentUser.uid);

      store.dispatch(HunterLoginAction(hunter));
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (Route<dynamic> route) => false);
    });
  };
}

ThunkAction<AppState> handleAutoLoginAction(BuildContext context) {
  return (Store<AppState> store) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    new Future(() async {
      User user = _auth.currentUser;
      if (user is User) {
        store.dispatch(HunterLoginAction(Hunter.fromFirebaseUser(user)));

        Navigator.pushNamedAndRemoveUntil(context, Routes.home, (Route<dynamic> route) => false);
      }
    });
  };
}

ThunkAction<AppState> handleLogoutAction(BuildContext context) {
  return (Store<AppState> store) async {
    new Future(() async {
      await _googleSignIn.signOut();
      await _auth.signOut();
      store.dispatch(HunterLogoutAction());
      Navigator.pushNamedAndRemoveUntil(context, Routes.login, (Route<dynamic> route) => false);
    });
  };
}

ThunkAction createHunterAction(Hunter hunter) {
  HunterRepository _hunterRepository = new HunterRepository();

  return (Store store) async {
    new Future(() async {
      store.dispatch(new CreateHunterRequestAction());
      _hunterRepository.createHunter(hunter).then((hunter) async {
        store.dispatch(new CreateHunterSuccessAction());
      }, onError: (error) {
        store.dispatch(new CreateHunterFailureAction());
      });
    });
  };
}
