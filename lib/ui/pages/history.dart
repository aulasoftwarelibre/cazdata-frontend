import 'package:flutter/material.dart';

class History extends StatelessWidget {
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
          "Historial",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        color: Colors.blue,
      )),
    );
  }
}