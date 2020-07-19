import 'dart:async';

import 'package:cazdata_frontend/model/animal.dart';
import 'package:cazdata_frontend/model/journey.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWithGoogleAction {
  final Completer completer;

  LoginWithGoogleAction({Completer completer})
      : this.completer = completer ?? Completer();
}

class LogoutAction {
  LogoutAction();
}

class UserLoadedAction {
  final FirebaseUser firebaseUser;
  final String idTokenUser;

  UserLoadedAction(this.firebaseUser, this.idTokenUser);
}

class UserIsNew {
  final bool userIsNew;

  UserIsNew(this.userIsNew);
}

class StartLoadingAnimalsAction {
  StartLoadingAnimalsAction();
}

class AnimalsLoadedAction {
  final AnimalsList animalsList;

  AnimalsLoadedAction(this.animalsList);
}

class AnimalsLoadFailedAction {
  AnimalsLoadFailedAction();
}

class UpdateAnimalsAction {
  final List<Animal> animals;

  UpdateAnimalsAction(this.animals);
}

class SaveCurrentJourney {
  final Journey journey;

  SaveCurrentJourney(this.journey);
}

class CleanCurrentJourney {
  CleanCurrentJourney();
}

class StartSendingJourneyAction {
  StartSendingJourneyAction();
}

class SendingJourneySuccessAction {
  SendingJourneySuccessAction();
}

class SendingJourneyFailedAction {
  SendingJourneyFailedAction();
}
