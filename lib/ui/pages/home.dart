import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CazData'),
      ),
      body: Center(
          child: Container(
        alignment: Alignment.center,
        height: 300,
        width: 300,
        child: Text(
          "Inicio",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        color: Colors.amber,
      )),
    );
  }
}