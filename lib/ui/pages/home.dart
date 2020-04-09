import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 16),
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Mapa de Inicio',
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      fontSize: 38),
                ),
              ],
            ),
            //Add map component and user name as a card
          ]),
        )
      ]),
    );
  }
}