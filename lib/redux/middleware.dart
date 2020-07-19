import 'package:cazdata_frontend/model/animal.dart';
import 'package:cazdata_frontend/model/journey.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/services/repository/animal.repository.dart';
import 'package:cazdata_frontend/services/repository/journey.repository.dart';
import 'package:cazdata_frontend/util/keys.dart';
import 'package:cazdata_frontend/util/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

middleware(Store<AppState> store, action, NextDispatcher next) {
  print(action.runtimeType);

  if (action is LoginWithGoogleAction) {
    _handleLoginWithGoogle(store, action, next);
  } else if (action is LogoutAction) {
    _handleLogoutAction(store, action);
  } else if (action is StartLoadingAnimalsAction) {
    _handleStartLoadingAnimalsAction(store, action);
  }

  next(action);
}

_handleLoginWithGoogle(Store<AppState> store, LoginWithGoogleAction action,
    NextDispatcher next) async {
  GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);

  if (authResult.additionalUserInfo.isNewUser) {
    store.dispatch(UserIsNew(true));
    next(UserIsNew);
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

_handleStartLoadingAnimalsAction(
    Store<AppState> store, StartLoadingAnimalsAction action) async {
  AnimalRepository animalRepository = new AnimalRepository();
  AnimalsList animalsList = await animalRepository.getAnimals();

  if (animalsList != null) {
    store.dispatch(AnimalsLoadedAction(animalsList));
  } else {
    store.dispatch(AnimalsLoadFailedAction());

    //On fail try to load animals every 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      store.dispatch(StartLoadingAnimalsAction());
    });
  }
}

ThunkAction postCurrentJourney(Journey journey, String tokenId) {
  JourneyRepository _journeyRepository = new JourneyRepository();

  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartSendingJourneyAction());
      _journeyRepository.postJourney(journey, tokenId).then((journey) async {
        store.dispatch(new SendingJourneySuccessAction());
        Keys.navKey.currentState.pushNamed(Routes.homePage);
      }, onError: (error) {
        store.dispatch(new SendingJourneyFailedAction());
      });
    });
  };
}
