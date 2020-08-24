import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginAction {}

class LoginWithGoogleRequestAction extends LoginAction {
  final Completer completer;

  LoginWithGoogleRequestAction({Completer completer}) : this.completer = completer ?? Completer();
}

class LoginWithGoogleSuccessAction extends LoginAction {
  final FirebaseUser firebaseUser;

  LoginWithGoogleSuccessAction(this.firebaseUser);
}

class LogoutRequestAction extends LoginAction {
  LogoutRequestAction();
}

class UserIsNewAction extends LoginAction {
  final bool userIsNew;

  UserIsNewAction(this.userIsNew);
}
