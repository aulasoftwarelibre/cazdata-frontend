import 'package:cazdata_frontend/features/hunter/actions.dart';
import 'package:cazdata_frontend/models/hunter/hunter.dart';
import 'package:cazdata_frontend/models/hunter/hunter.repository.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

loginMiddleware(Store<AppState> store, LoginAction action, NextDispatcher next) {
  if (action is LoginWithGoogleRequestAction) {
    _handleLoginWithGoogleAction(store, action, next);
  } else if (action is LogoutRequestAction) {
    _handleLogoutRequestAction(store, action);
  }
}

_handleLoginWithGoogleAction(Store<AppState> store, LoginWithGoogleRequestAction action, NextDispatcher next) async {
  GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  Hunter hunter = new Hunter(
      id: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
      isEmailVerified: user.isEmailVerified);

  if (authResult.additionalUserInfo.isNewUser) {
    store.dispatch(HunterIsNewAction(true));
    next(HunterIsNewAction);

    store.dispatch(createHunterAction(hunter));
  }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  store.dispatch(LoginWithGoogleSuccessAction(hunter));

  action.completer.complete();
}

_handleLogoutRequestAction(Store<AppState> store, LogoutRequestAction action) async {
  await _googleSignIn.signOut();
}

ThunkAction createHunterAction(Hunter hunter) {
  HunterRepository _hunterRepository = new HunterRepository();

  return (Store store) async {
    new Future(() async {
      store.dispatch(new CreateHunterRequestAction());
      _hunterRepository.createHunter(hunter).then((hunter) async {
        store.dispatch(new CreateHunterSuccessAction());
        store.dispatch(new HunterIsNewAction(false));
      }, onError: (error) {
        store.dispatch(new CreateHunterFailureAction());
      });
    });
  };
}
