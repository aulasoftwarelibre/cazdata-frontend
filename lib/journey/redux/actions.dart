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
