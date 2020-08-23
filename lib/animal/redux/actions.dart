import 'package:cazdata_frontend/animal/model/animal.dart';

abstract class AnimalAction {}

class LoadAnimalsRequestAction extends AnimalAction {
  LoadAnimalsRequestAction();
}

class LoadAnimalsSuccessAction extends AnimalAction {
  final AnimalsList animalsList;

  LoadAnimalsSuccessAction(this.animalsList);
}

class LoadAnimalsFailureAction extends AnimalAction {
  LoadAnimalsFailureAction();
}
