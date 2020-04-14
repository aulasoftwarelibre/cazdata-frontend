import 'package:cazdata_frontend/util/colors.dart';
import 'package:flutter/material.dart';

class DataOnMapWidget extends StatelessWidget {
  const DataOnMapWidget({this.distance, this.time, this.calories});

  final String distance;
  final String time;
  final String calories;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
          inherit: true,
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Montserrat',
          decoration: TextDecoration.none,
          decorationColor: Colors.black,
          decorationStyle: TextDecorationStyle.solid,
          color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 30.0),
              child: InformationWidget(
                mainInformation: distance,
                subtitle: "Km totales",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: InformationWidget(
                mainInformation: time + " min",
                subtitle: "Tiempo total",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InformationWidget(
                mainInformation: calories,
                subtitle: "Calorias",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InformationWidget extends StatelessWidget {
  final String mainInformation;
  final String subtitle;

  InformationWidget({this.mainInformation, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: TextStyle(
            inherit: true,
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'Montserrat',
            decoration: TextDecoration.none,
            decorationColor: Colors.black,
            decorationStyle: TextDecorationStyle.solid,
            color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.only( left:8.0, bottom: 8.0 ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  mainInformation,
                  style: TextStyle(fontSize: 20, color: primaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  subtitle,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ));
  }
}
