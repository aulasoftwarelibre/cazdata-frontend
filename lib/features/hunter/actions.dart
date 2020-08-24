import 'package:cazdata_frontend/models/hunter/hunter.dart';
import 'dart:async';

abstract class HunterAction {}

abstract class LoginAction {}

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

class HunterIsNewAction extends LoginAction {
  final bool userIsNew;

  HunterIsNewAction(this.userIsNew);
}

class CreateHunterRequestAction extends HunterAction {
  CreateHunterRequestAction();
}

class CreateHunterSuccessAction extends HunterAction {
  CreateHunterSuccessAction();
}

class CreateHunterFailureAction extends HunterAction {
  CreateHunterFailureAction();
}
