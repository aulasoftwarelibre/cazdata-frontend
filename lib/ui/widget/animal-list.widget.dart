import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/widget/animal-tile.widget.dart';
import 'package:cazdata_frontend/ui/widget/separator.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final AnimalsListState animalsListState;

  _ViewModel(this.animalsListState);

  factory _ViewModel.create(Store<AppState> store) {
    AnimalsListState animalsListState = store.state.animalsListState;

    return _ViewModel(animalsListState);
  }
}

class AnimalsList extends StatelessWidget {
  AnimalsList();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      onInit: (store) {
        if (store.state.animalsListState.animals == null)
          store.dispatch(StartLoadingAnimalsAction());
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
    if (viewModel.animalsListState.isLoading) {
      return CircularProgressIndicator();
    } else if (viewModel.animalsListState.errorLoading) {
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
    } else if (viewModel.animalsListState.animals != null) {
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: viewModel.animalsListState.animals.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
              child:
                  AnimalTile(animal: viewModel.animalsListState.animals[index]),
            );
          },
        ),
      );
    } else {
      return Separator.none();
    }
  }
}
