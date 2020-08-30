import 'package:cazdata_frontend/models/modality/modality.dart';

abstract class ModalityAction {}

class LoadModalitiesRequestAction extends ModalityAction {
  LoadModalitiesRequestAction();
}

class LoadModalitiesSuccessAction extends ModalityAction {
  final ModalitiesList modalitiesList;

  LoadModalitiesSuccessAction(this.modalitiesList);
}

class LoadModalitiesFailureAction extends ModalityAction {
  LoadModalitiesFailureAction();
}
