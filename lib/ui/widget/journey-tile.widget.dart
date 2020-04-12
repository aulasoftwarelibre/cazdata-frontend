

import 'package:flutter/material.dart';

class JourneyTile extends StatelessWidget {

  final String title;
  final String startTime;

  const JourneyTile({
    this.title,
    this.startTime,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FlutterLogo(),
        title: Text(this.title),
        subtitle: Text(this.startTime),
        trailing: Icon(Icons.keyboard_arrow_right)
      ),
    );
  }
}
