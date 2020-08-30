import 'package:cazdata_frontend/features/current-journey/actions.dart';
import 'package:cazdata_frontend/features/modalities-list/middleware.dart';
import 'package:cazdata_frontend/features/modalities-list/state.dart';
import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final ModalitiesListState _modalitiesListState;
  final Function(String) updateModality;

  _ViewModel(this._modalitiesListState, this.updateModality);

  factory _ViewModel.create(Store<AppState> store) {
    ModalitiesListState modalitiesListState = store.state.modalitiesListState;

    return _ViewModel(modalitiesListState, (String modality) => store.dispatch(UpdateModalityAction(modality)));
  }
}

class ModalitiesListWidget extends StatelessWidget {
  final _dropdownButtonFormFieldKey = GlobalKey<FormFieldState>();
  final Journey journey;
  final Function(String) update;

  ModalitiesListWidget(this.journey, this.update);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(onInit: (store) {
      if (store.state.modalitiesListState.modalities == null) store.dispatch(handleLoadModalitiesAction());
    }, builder: (BuildContext context, _ViewModel viewModel) {
      return _widgetView(context, viewModel);
    }, converter: (Store<AppState> store) {
      return new _ViewModel.create(store);
    });
  }

  Widget _widgetView(BuildContext context, _ViewModel _viewModel) {
    return DropdownButtonFormField(
      key: _dropdownButtonFormFieldKey,
      value: this.journey.modality,
      icon: Icon(Icons.arrow_drop_down),
      decoration: InputDecoration(
        labelText: 'Modalidad',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: _getHuntModalities(_viewModel),
      validator: _validateModality,
      onChanged: (modality) {
        this.update(modality);
      },
      onSaved: (modality) {
        this.update(modality);
      },
    );
  }

  List<DropdownMenuItem<String>> _getHuntModalities(_ViewModel _viewModel) {
    return _viewModel._modalitiesListState.modalities.map((modality) {
      return DropdownMenuItem(
        value: modality.name,
        child: Text(
          modality.name,
        ),
      );
    }).toList();
  }

  String _validateModality(String modality) {
    if (modality == null) {
      return 'Seleccione una modalidad para la jornada';
    }
    return null;
  }
}
