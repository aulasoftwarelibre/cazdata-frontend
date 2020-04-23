import 'package:cazdata_frontend/ui/widget/separator.widget.dart';
import 'package:cazdata_frontend/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:cazdata_frontend/model/journey.dart';

import '../../model/journey.dart';

class Configurator extends StatefulWidget {
  @override
  ConfiguratorState createState() {
    return ConfiguratorState();
  }
}

class ConfiguratorState extends State<Configurator> {
  final _formKey = GlobalKey<FormState>();

  Journey _journey = Journey();

  final FocusNode _modalityFocus = FocusNode();
  int _huntType = 0;

  void _handleHuntTypeChange(int value) {
    setState(() {
      _huntType = value;
    });
  }

  String _validateTitle(String title) {
    if (title.isEmpty) {
      return 'Introduzca un título para la jornada';
    }
    return null;
  }

  String _validateModality(String modality) {
    if (modality.isEmpty) {
      return 'Introduzca una modalidad para la jornada';
    }
    return null;
  }

  void submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      //Save the hunt type
      if(_huntType == 0)
        _journey.type = "Menor";
      else
        _journey.type = "Mayor";

      print('Printing the form data.');
      print('Title: ${_journey.title}');
      print('Modality: ${_journey.modality}');
      print('Type: ${_journey.type}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Container(
                margin: new EdgeInsets.only(top: 48, left: 16, right: 16),
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
                      textInputAction: TextInputAction.next,
                      //When the user finish with this field pass to the next one
                      onFieldSubmitted: (term) {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        currentFocus.unfocus();

                        FocusScope.of(context).requestFocus(_modalityFocus);
                      },
                      validator: _validateTitle,
                      onSaved: (title) => _journey.title = title,
                    ),
                    Separator.spacer(
                      height: 24,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Modalidad',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      focusNode: _modalityFocus,
                      textInputAction: TextInputAction.done,
                      validator: _validateModality,
                      onSaved: (modality) => _journey.modality = modality,
                    ),
                    Separator.spacer(
                      height: 40,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Tipo de Caza',
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
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: _huntType,
                          activeColor: Color.fromARGB(255, 100, 100, 100),
                          onChanged: _handleHuntTypeChange,
                        ),
                        Text(
                          'Menor',
                          style: TextStyle(fontSize: 20),
                        ),
                        Separator.spacer(
                          width: 16,
                          height: 0,
                        ),
                        Radio(
                          value: 1,
                          groupValue: _huntType,
                          activeColor: Color.fromARGB(255, 100, 100, 100),
                          onChanged: _handleHuntTypeChange,
                        ),
                        Text(
                          'Mayor',
                          style: TextStyle(fontSize: 20),
                        ),
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
                              onPressed: submit,
                              color: primaryColor,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "Siguiente",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
