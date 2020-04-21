import 'package:cazdata_frontend/ui/widget/separator.widget.dart';
import 'package:cazdata_frontend/util/colors.dart';
import 'package:flutter/material.dart';

class Configurator extends StatefulWidget {
  @override
  ConfiguratorState createState() {
    return ConfiguratorState();
  }
}

class ConfiguratorState extends State<Configurator> {
  int _huntType = 0;

  void _handleHuntTypeChange(int value) {
    setState(() {
      _huntType = value;
    });
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 18),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ButtonTheme(
                  height: 50,
                  child: FlatButton(
                    onPressed: () {},
                    color: primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                    ),
                    child: Text(
                      "Siguiente",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 48),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          iconSize: 50,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, left: 16),
                    child: Row(
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        /* Save the information */
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Modalidad',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        /* Save the information */
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 16),
                    child: Row(
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, left: 8),
                    child: Row(
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
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Radio(
                            value: 1,
                            groupValue: _huntType,
                            activeColor: Color.fromARGB(255, 100, 100, 100),
                            onChanged: _handleHuntTypeChange,
                          ),
                        ),
                        Text(
                          'Mayor',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Separator.spacer(height: 112,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
