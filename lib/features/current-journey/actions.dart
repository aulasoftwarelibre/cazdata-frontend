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

class SendJourneyRequestAction extends CurrentJourneyAction {
  SendJourneyRequestAction();
}

class SendJourneySuccessAction extends CurrentJourneyAction {
  SendJourneySuccessAction();
}

class SendJourneyFailureAction extends CurrentJourneyAction {
  SendJourneyFailureAction();
}

class UpdateAnimalsAction extends CurrentJourneyAction {
  final List<Animal> animals;

  UpdateAnimalsAction(this.animals);
}

class AddHuntedAnimalAction extends CurrentJourneyAction {
  final HuntedAnimal huntedAnimal;

  AddHuntedAnimalAction(this.huntedAnimal);
}
