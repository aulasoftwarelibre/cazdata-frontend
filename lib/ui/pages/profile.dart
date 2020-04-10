import 'package:cazdata_frontend/ui/widget/index.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
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
                          'Cuenta',
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: FlatButton(
                          onPressed: () {
                            /*...*/
                          },
                          color: Colors.red,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0)),
                          child: Text("Cerrar sesión",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Perfil',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  ProfileWidget(
                      name: 'Adrián López',
                      location: 'Córdoba, España',
                      profilePic: 'AL'),
                  Divider(),
                  TextFieldWidget(header: 'Flying to', content: 'Flying to'),
                  TextFieldWidget(
                      header: 'Nivel Cazador', content: 'Novato (10)'),
                  TextFieldWidget(
                      header: 'Descripción',
                      content:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
