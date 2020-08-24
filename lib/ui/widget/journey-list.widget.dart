import 'package:cazdata_frontend/features/journey-list/actions.dart';
import 'package:cazdata_frontend/features/journey-list/state.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/widget/journey-tile.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final HunterJourneysState _hunterJourneysState;

  _ViewModel(this._hunterJourneysState);

  factory _ViewModel.create(Store<AppState> store) {
    HunterJourneysState hunterJourneysState = store.state.hunterJourneysState;

    return _ViewModel(hunterJourneysState);
  }
}

class JourneysList extends StatelessWidget {
  JourneysList();

  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(onInit: (store) {
      if (store.state.hunterJourneysState.journeysList.journeys == null) {
        store.dispatch(LoadJourneysRequestAction());
      }
    }, builder: (BuildContext context, _ViewModel viewModel) {
      return _widgetView(context, viewModel);
    }, converter: (Store<AppState> store) {
      return new _ViewModel.create(store);
    });
  }

  Widget _widgetView(BuildContext context, _ViewModel viewModel) {
    if (viewModel._hunterJourneysState.isLoading) {
      return CircularProgressIndicator();
    }

    if (viewModel._hunterJourneysState.errorLoading) {
      return Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Error al recibir jornadas",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel._hunterJourneysState.journeysList.journeys != null
                ? viewModel._hunterJourneysState.journeysList.journeys.length
                : 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
                child: JourneyTile(journey: viewModel._hunterJourneysState.journeysList.journeys[index]),
              );
            }));
  }
}
