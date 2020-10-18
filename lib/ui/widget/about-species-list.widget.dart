import 'package:cazdata_frontend/features/animal-list/state.dart';
import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/widget/about-specie.widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel();

  factory _ViewModel.create(Store<AppState> store) {
    return _ViewModel();
  }
}

class AnimalSpeciesList extends StatelessWidget {
  AnimalSpeciesList();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(builder: (BuildContext context, _ViewModel viewModel) {
      return _widgetView(context, viewModel);
    }, converter: (Store<AppState> store) {
      return new _ViewModel.create(store);
    });
  }

  Widget _widgetView(BuildContext context, _ViewModel _viewModel) {
    final Query animals = FirebaseFirestore.instance.collection('animals');

    return StreamBuilder<QuerySnapshot>(
      stream: animals.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Error al leer los animales");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new AnimalSpecie(
              key: Key(document.id),
              animal: Animal.fromJson(document.id, document.data()),
            );
          }).toList(),
        );
      },
    );
  }
}
