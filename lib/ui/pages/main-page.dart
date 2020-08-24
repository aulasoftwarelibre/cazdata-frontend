import 'package:cazdata_frontend/ui/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.calendar_today)),
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.account_circle))
                ],
              ),
              title: Text('Example'),
            ),
            body: TabBarView(
              children: [
                History(),
                Home(),
                Profile(),
              ],
            ),
          )),
    );
  }
}
