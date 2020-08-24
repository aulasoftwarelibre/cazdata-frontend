import 'package:cazdata_frontend/features/hunter/middleware.dart';
import 'package:cazdata_frontend/models/hunter/hunter.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';

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

  if (authResult.additionalUserInfo.isNewUser) {
    store.dispatch(UserIsNewAction(true));
    next(UserIsNewAction);

    Hunter hunter = new Hunter(
        id: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoUrl,
        isEmailVerified: user.isEmailVerified);
        
    store.dispatch(createHunterAction(hunter));
  }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  store.dispatch(LoginWithGoogleSuccessAction(currentUser));

  action.completer.complete();
}

_handleLogoutRequestAction(Store<AppState> store, LogoutRequestAction action) async {
  await _googleSignIn.signOut();
}
