import 'package:cazdata_frontend/models/hunter/hunter.dart';

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

class HunterLoginAction extends HunterAction {
  final Hunter hunter;

  HunterLoginAction(this.hunter);
}

class HunterLogoutAction extends HunterAction {
  HunterLogoutAction();
}
