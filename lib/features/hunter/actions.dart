abstract class HunterAction {}

class CreateHunterRequestAction extends HunterAction {
  CreateHunterRequestAction();
}

class CreateHunterSuccessAction extends HunterAction {
  CreateHunterSuccessAction();
}

class CreateHunterFailureAction extends HunterAction {
  CreateHunterFailureAction();
}
