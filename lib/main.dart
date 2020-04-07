import 'package:flutter/material.dart';
import 'util/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CazData',
      theme: ThemeData(primaryColor: primaryColor, accentColor: accentColor),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
