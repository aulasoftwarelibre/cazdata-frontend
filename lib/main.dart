import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Montserrat'),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Historial'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Inicio'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Cuenta'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({this.name, this.location, this.profilePic});

  final String name;
  final String location;
  final String profilePic;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.brown.shade800,
            child: Text(profilePic),
          ),
          Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFieldWidget(header: name, content: location)),
        ],
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({this.header, this.content});

  final String header;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                  text: header,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  )),
              TextSpan(text: '\n'),
              TextSpan(
                  text: content,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                  )),
            ]),
      ),
    );
  }
}
