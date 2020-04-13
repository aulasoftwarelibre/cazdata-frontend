import 'package:cazdata_frontend/model/journey.dart';
import 'package:cazdata_frontend/ui/widget/data-on-map.widget.dart';
import 'package:cazdata_frontend/util/colors.dart';
import 'package:flutter/material.dart';

class DetailsJourney extends StatelessWidget {
  
  final Journey journey;

  const DetailsJourney({
    this.journey,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DateTime startTime = DateTime.parse(journey.startTime);
    DateTime endTime = DateTime.parse(journey.endTime);
    final int difference = endTime.difference(startTime).inMinutes;

    return Scaffold(
      appBar: AppBar(
        title: Text('CazData'),
      ),
      body: DefaultTextStyle(
        style: TextStyle(
            inherit: true,
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'Montserrat',
            decoration: TextDecoration.none,
            decorationColor: Colors.black,
            decorationStyle: TextDecorationStyle.solid,
            color: Colors.black),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Detalle Jornada',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Información',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        journey.title,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        journey.startTime.substring(0,10),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          color: Color.fromARGB(255, 241, 243, 246),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            )                          
                          ),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    DataOnMapWidget(
                                      distance: journey.distance.toString(),
                                      time: difference.toString(),
                                      calories: journey.calories.toString()
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width - 78,
                                      height: MediaQuery.of(context).size.height - 440,
                                    )
                                  ],
                                ),
                              ],
                            )    
                          )
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                          child: FlatButton(
                          onPressed: () {
                            /*...*/
                          },
                          color: greenLight,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0)),
                          child: Text("Compartir jornada",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                    )
                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
