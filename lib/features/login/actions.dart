import 'package:cazdata_frontend/models/hunter/hunter.dart';
import 'dart:async';

abstract class LoginAction {}

class AutoLoginRequestAction extends LoginAction {
  AutoLoginRequestAction();
}

class AutoLoginSuccessAction extends LoginAction {
  AutoLoginSuccessAction();
}

class AutoLoginFailureAction extends LoginAction {
  AutoLoginFailureAction();
}

class LoginWithGoogleRequestAction extends LoginAction {
  final Completer completer;

  LoginWithGoogleRequestAction({Completer completer}) : this.completer = completer ?? Completer();
}

class LoginWithGoogleSuccessAction extends LoginAction {
  final Hunter hunter;
  LoginWithGoogleSuccessAction(this.hunter);
}

class LogoutRequestAction extends LoginAction {
  LogoutRequestAction();
}

class LoginIsNewAction extends LoginAction {
  final bool userIsNew;

  LoginIsNewAction(this.userIsNew);
}
