import 'package:cazdata_frontend/redux/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

loginMiddleware(Store<AppState> store, LoginAction action, NextDispatcher next) {
  if (action is LoginWithGoogleAction) {
    _handleLoginWithGoogleAction(store, action, next);
  } else if (action is LogoutAction) {
    _handleLogoutAction(store, action);
  }
}

_handleLoginWithGoogleAction(Store<AppState> store, LoginWithGoogleAction action, NextDispatcher next) async {
  GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);

  if (authResult.additionalUserInfo.isNewUser) {
    store.dispatch(UserIsNewAction(true));
    next(UserIsNewAction);
  }

  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  final IdTokenResult token = await currentUser.getIdToken();

  store.dispatch(UserLoadedAction(currentUser, token.token));

  action.completer.complete();
}

_handleLogoutAction(Store<AppState> store, LogoutAction action) async {
  await _googleSignIn.signOut();
}
