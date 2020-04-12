import 'package:cazdata_frontend/services/repository/journey.repository.dart';
import 'package:cazdata_frontend/ui/widget/bottom-navigation-bar.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Montserrat'),
      home: ChangeNotifierProvider<BottomNavigationBarProvider>(
        child: BottomNavigationBarWidget(),
        create: (BuildContext context) => BottomNavigationBarProvider(),
      ),
    );
  }
}

