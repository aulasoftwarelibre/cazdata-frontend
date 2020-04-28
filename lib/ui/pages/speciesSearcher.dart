import 'package:cazdata_frontend/model/journey.dart';
import 'package:cazdata_frontend/ui/widget/separator.widget.dart';
import 'package:cazdata_frontend/util/colors.dart';
import 'package:flutter/material.dart';

class SpeciesSearcher extends StatefulWidget {
  final Journey journey;

  SpeciesSearcher({@required this.journey, Key key}) : super(key: key);

  @override
  SpeciesSearcherState createState() {
    return SpeciesSearcherState(journey);
  }
}

class SpeciesSearcherState extends State<SpeciesSearcher> {
  final _formKey = GlobalKey<FormState>();

  Journey _journey;

  SpeciesSearcherState(this._journey);

  @override
  Widget build(BuildContext context) {
    print('Printing the form data.');
    print('Title: ${_journey.title}');
    print('Modality: ${_journey.modality}');
    print('Type: ${_journey.type}');

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(top: 72, left: 16, right: 16, bottom: 32),
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
                    'Buscador Especies',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 31,
                    ),
                  ),
                ],
              ),
              Separator.spacer(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Caza ${_journey.type.toLowerCase()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              Separator.spacer(
                height: 4,
              ),
              Expanded(
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  children: [
                    /* Widget list with animals */
                  ],
                ),
              ),
              Separator.spacer(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonTheme(
                      height: 50,
                      child: FlatButton(
                        onPressed: () {/* Start journey */},
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
        ),
      ),
    );
  }
}
