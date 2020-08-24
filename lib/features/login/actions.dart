import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginAction {}

class LoginWithGoogleAction extends LoginAction {
  final Completer completer;

  LoginWithGoogleAction({Completer completer}) : this.completer = completer ?? Completer();
}

class LogoutAction extends LoginAction {
  LogoutAction();
}

class UserLoadedAction extends LoginAction {
  final FirebaseUser firebaseUser;
  final String idTokenUser;

  UserLoadedAction(this.firebaseUser, this.idTokenUser);
}

class UserIsNewAction extends LoginAction {
  final bool userIsNew;

  UserIsNewAction(this.userIsNew);
}
