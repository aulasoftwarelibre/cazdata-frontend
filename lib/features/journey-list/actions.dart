import 'package:cazdata_frontend/models/journey/journey.dart';

abstract class JourneyListAction {}

class LoadJourneysRequestAction extends JourneyListAction {
  LoadJourneysRequestAction();
}

class LoadJourneysSuccessAction extends JourneyListAction {
  final JourneysList journeysList;

  LoadJourneysSuccessAction(this.journeysList);
}

class LoadJourneysFailureAction extends JourneyListAction {
  LoadJourneysFailureAction();
}
