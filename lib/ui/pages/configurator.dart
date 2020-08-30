import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/features/current-journey/actions.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/widget/modalities-list.widget.dart';
import 'package:cazdata_frontend/ui/widget/species-list.widget.dart';
import 'package:cazdata_frontend/ui/widget/separator.widget.dart';
import 'package:cazdata_frontend/util/colors.dart';
import 'package:cazdata_frontend/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../models/journey/journey.dart';

class Configurator extends StatefulWidget {
  @override
  ConfiguratorState createState() {
    return ConfiguratorState();
  }
}

class ConfiguratorState extends State<Configurator> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  Journey _journey = Journey(
      startsAt: DateTime.now(),
      endsAt: DateTime.now(),
      calories: 0,
      distance: 0,
      hunterId: null,
      minutes: 0,
      modality: null);

  String _validateTitle(String title) {
    if (title.isEmpty) {
      return 'Introduzca un título para la jornada';
    }
    return null;
  }

  void submit(_ViewModel vm) {
    // First validate form.
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      //Save the hunt type
      setState(() {
        _journey.type = "Menor";
      });

      if (vm.journeyAnimals.length != 0) {
        vm.saveJourney(_journey);

        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.journey);
      } else {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Selecciona al menos una especie'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Completa todos los campos'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel.fromStore(store);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return _formView(context, vm);
      },
      onInit: (store) {
        store.dispatch(CleanCurrentJourneyAction());
      },
    );
  }

  Widget _formView(BuildContext context, _ViewModel _viewModel) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: _formKey,
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 40),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          padding: EdgeInsets.zero,
                          iconSize: 50,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    Separator.spacer(
                      height: 24,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Pre-Configurador',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 31,
                          ),
                        ),
                      ],
                    ),
                    Separator.spacer(
                      height: 24,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      validator: _validateTitle,
                      onSaved: (title) {
                        setState(() {
                          _journey.title = title;
                        });
                      },
                    ),
                    Separator.spacer(
                      height: 24,
                    ),
                    ModalitiesListWidget(
                        _journey,
                        (modality) => setState(() {
                              _journey.modality = modality;
                            })),
                    Separator.spacer(
                      height: 40,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Seleccione las especies',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 150, 150, 150),
                          ),
                        ),
                      ],
                    ),
                    Separator.spacer(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SpeciesList(),
                      ],
                    ),
                    Separator.spacer(
                      height: 40,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ButtonTheme(
                            height: 50,
                            child: FlatButton(
                              onPressed: () {
                                submit(_viewModel);
                              },
                              color: primaryColor,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "Siguiente",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final Function(Journey) saveJourney;
  final List<Animal> journeyAnimals;

  _ViewModel({
    @required this.saveJourney,
    @required this.journeyAnimals,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      saveJourney: (Journey journey) {
        store.dispatch(SaveCurrentJourneyAction(journey));
      },
      journeyAnimals: store.state.currentJourneyState.selectedAnimals,
    );
  }
}
