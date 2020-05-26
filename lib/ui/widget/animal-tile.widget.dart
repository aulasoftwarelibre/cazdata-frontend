import 'package:cazdata_frontend/model/animal.dart';
import 'package:flutter/material.dart';

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
    return CheckboxListTile(
      title: Text(this.widget._animal.name),
      value: _checkboxValue,
      onChanged: (val) {
        if (_checkboxValue == false) {
          setState(() {
            _checkboxValue = true;
          });
        } else if (_checkboxValue == true) {
          setState(() {
            _checkboxValue = false;
          });
        }
      },
    );
  }
}
