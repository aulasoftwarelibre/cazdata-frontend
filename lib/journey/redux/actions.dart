import 'package:cazdata_frontend/animal/model/animal.dart';
import 'package:cazdata_frontend/animal/model/hunted-animal.dart';
import 'package:cazdata_frontend/journey/model/journey.dart';

abstract class JourneyAction {}

class CleanCurrentJourneyAction extends JourneyAction {
  CleanCurrentJourneyAction();
}

class SaveCurrentJourneyAction extends JourneyAction {
  final Journey journey;

  SaveCurrentJourneyAction(this.journey);
}

class StartSendingJourneyAction extends JourneyAction {
  StartSendingJourneyAction();
}

class SendingJourneySuccessAction extends JourneyAction {
  SendingJourneySuccessAction();
}

class SendingJourneyFailedAction extends JourneyAction {
  SendingJourneyFailedAction();
}

class LoadJourneysRequestAction extends JourneyAction {
  LoadJourneysRequestAction();
}

class LoadJourneysSuccessAction extends JourneyAction {
  final JourneysList journeysList;

  LoadJourneysSuccessAction(this.journeysList);
}

class LoadJourneysFailureAction extends JourneyAction {
  LoadJourneysFailureAction();
}

class UpdateAnimalsAction {
  final List<Animal> animals;

  UpdateAnimalsAction(this.animals);
}

class AddHuntedAnimalAction {
  final HuntedAnimal huntedAnimal;

  AddHuntedAnimalAction(this.huntedAnimal);
}
