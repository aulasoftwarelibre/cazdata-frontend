import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/models/animal/hunted-animal.dart';
import 'package:cazdata_frontend/models/journey/journey.dart';

abstract class CurrentJourneyAction {}

class CleanCurrentJourneyAction extends CurrentJourneyAction {
  CleanCurrentJourneyAction();
}

class SaveCurrentJourneyAction extends CurrentJourneyAction {
  final Journey journey;

  SaveCurrentJourneyAction(this.journey);
}

class StartSendingJourneyAction extends CurrentJourneyAction {
  StartSendingJourneyAction();
}

class SendingJourneySuccessAction extends CurrentJourneyAction {
  SendingJourneySuccessAction();
}

class SendingJourneyFailedAction extends CurrentJourneyAction {
  SendingJourneyFailedAction();
}

class UpdateAnimalsAction {
  final List<Animal> animals;

  UpdateAnimalsAction(this.animals);
}

class AddHuntedAnimalAction {
  final HuntedAnimal huntedAnimal;

  AddHuntedAnimalAction(this.huntedAnimal);
}
