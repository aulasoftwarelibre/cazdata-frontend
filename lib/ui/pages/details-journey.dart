import 'package:auto_size_text/auto_size_text.dart';
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: DefaultTextStyle(
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
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      padding: EdgeInsets.zero,
                      iconSize: 50,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Center(
                              child: AutoSizeText(
                                journey.title +
                                    " | " +
                                    journey.startTime.substring(0, 10),
                                style: TextStyle(fontSize: 20),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                minFontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Card(
                              color: Color.fromARGB(255, 241, 243, 246),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              )),
                              child: Center(
                                  child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      DataOnMapWidget(
                                          distance: journey.distance.toString(),
                                          time: difference.toString(),
                                          calories: journey.calories.toString())
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.14,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.99,
                                      )
                                    ],
                                  ),
                                ],
                              ))),
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
                            color: primaryColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0)),
                            child: Text("Compartir jornada",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
