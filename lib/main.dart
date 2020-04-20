import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'util/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Store<AppState> store = createStore();
  
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: this.store,
        child: MaterialApp(
        title: 'CazData',
        theme: ThemeData(
            primaryColor: primaryColor,
            accentColor: accentColor,
            fontFamily: 'Montserrat'),
        home: LoginPage(),
      ),
    );
  }
}
