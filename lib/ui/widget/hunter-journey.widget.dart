import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:cazdata_frontend/util/routes.dart';
import 'package:flutter/material.dart';

class HunterJourney extends StatelessWidget {
  final Journey journey;

  const HunterJourney({
    this.journey,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(this.journey.title),
        subtitle: Text(this.journey.startsAt.toString().substring(0, 10)),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.pushNamed(context, Routes.detailsJourney, arguments: {'journey': journey});
        },
      ),
    );
  }
}
