import 'package:cazdata_frontend/ui/widget/journey-list.widget.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Historial',
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Listado Jornadas',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  JourneysList()
                ],
              ),
            ),
          ),
        ),
      ),        
    );
  }
}
