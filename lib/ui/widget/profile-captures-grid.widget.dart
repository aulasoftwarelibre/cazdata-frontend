import 'package:cazdata_frontend/features/hunter/state.dart';
import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/models/animal/hunted-animal.dart';
import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/util/reducers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final HunterState _hunterState;

  _ViewModel(this._hunterState);

  factory _ViewModel.create(Store<AppState> store) {
    HunterState hunterState = store.state.hunterState;

    return _ViewModel(hunterState);
  }
}

class ProfileCapturesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(builder: (BuildContext context, _ViewModel viewModel) {
      return _widgetView(context, viewModel);
    }, converter: (Store<AppState> store) {
      return new _ViewModel.create(store);
    });
  }

  Widget _widgetView(BuildContext context, _ViewModel _viewModel) {
    final String userId = _viewModel._hunterState.hunter.id;

    final Query journeys = FirebaseFirestore.instance
        .collection('journeys')
        .where('hunterId', isEqualTo: userId)
        .orderBy('endsAt', descending: true);

    return FutureBuilder<QuerySnapshot>(
        future: journeys.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error al leer las jornadas");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<Journey> journeyList = snapshot.data.docs.map((DocumentSnapshot document) {
            return Journey.fromJson(document.id, document.data());
          }).toList();

          Iterable<Map<HuntedAnimal, int>> totalHuntedAnimalsList = journeyList.map((journey) {
            return getNumberOfOccurrences(journey.huntedAnimals);
          });

          Map<Animal, int> topHuntedAnimalStatistics = new Map();
          totalHuntedAnimalsList.forEach((totalHuntedAnimalsItem) {
            totalHuntedAnimalsItem.forEach((key, value) {
              topHuntedAnimalStatistics.update(key.animal, (current) => current + value, ifAbsent: () => value);
            });
          });

          return Text("loading");
        });
  }
}
