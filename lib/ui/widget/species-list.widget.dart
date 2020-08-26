import 'package:cazdata_frontend/features/animal-list/middleware.dart';
import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/features/animal-list/state.dart';
import 'package:cazdata_frontend/features/current-journey/actions.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/widget/species-selection-grid.widget.dart';
import 'package:cazdata_frontend/ui/widget/separator.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final AnimalsListState _animalsListState;
  final Function(List<Animal>) updateAnimals;

  _ViewModel(this._animalsListState, this.updateAnimals);

  factory _ViewModel.create(Store<AppState> store) {
    AnimalsListState animalsListState = store.state.animalsListState;

    return _ViewModel(animalsListState, (List<Animal> animals) {
      store.dispatch(UpdateAnimalsAction(animals));
    });
  }
}

class SpeciesList extends StatelessWidget {
  SpeciesList();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      onInit: (store) {
        if (store.state.animalsListState.animals == null) store.dispatch(handleLoadAnimalsAction());
      },
      builder: (BuildContext context, _ViewModel viewModel) {
        return _widgetView(context, viewModel);
      },
      converter: (Store<AppState> store) {
        return new _ViewModel.create(store);
      },
    );
  }

  Widget _widgetView(BuildContext context, _ViewModel viewModel) {
    if (viewModel._animalsListState.isLoading) {
      return CircularProgressIndicator();
    }

    if (viewModel._animalsListState.errorLoading) {
      return Expanded(
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Error al recibir las especies",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      );
    }

    if (viewModel._animalsListState.animals != null) {
      List<Animal> animals = []..addAll(viewModel._animalsListState.animals);

      return Expanded(
        child: SpeciesSelectionGrid(
          buttonLabels: animals,
          buttonValuesList: animals,
          checkBoxButtonValues: (values) {
            viewModel.updateAnimals(values);
          },
          // hight: 50,
        ),
      );
    }

    return Separator.none();
  }
}
