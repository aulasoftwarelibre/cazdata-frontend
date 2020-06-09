import 'package:cazdata_frontend/model/animal.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class AnimalTile extends StatefulWidget {
  final Animal _animal;

  AnimalTile(this._animal);

  @override
  _AnimalTileState createState() => _AnimalTileState();
}

class _AnimalTileState extends State<AnimalTile> {
  bool _checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromStore(store),
        builder: (BuildContext context, _ViewModel vm) {
          return _animalTileView(context, vm);
        });
  }

  Widget _animalTileView(BuildContext context, _ViewModel vm) {
    return CheckboxListTile(
      title: Text(this.widget._animal.name),
      value: _checkboxValue,
      activeColor: accentColor,
      onChanged: (val) {
        if (_checkboxValue == false) {
          setState(() {
            _checkboxValue = true;
          });
          vm.addAnimal(this.widget._animal);
        } else if (_checkboxValue == true) {
          setState(() {
            _checkboxValue = false;
          });
          vm.removeAnimal(this.widget._animal);
        }
      },
    );
  }
}

class _ViewModel {
  final Function(Animal) addAnimal;
  final Function(Animal) removeAnimal;

  _ViewModel({
    this.addAnimal,
    this.removeAnimal,    
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      addAnimal: (Animal animal) {
        store.dispatch(AddAnimalAction(animal));
      },
      removeAnimal: (Animal animal) {
        store.dispatch(RemoveAnimalAction(animal));
      },
    );
  }
}

