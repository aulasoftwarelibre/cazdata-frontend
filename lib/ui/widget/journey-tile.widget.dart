import 'package:cazdata_frontend/model/journey.dart';
import 'package:cazdata_frontend/ui/pages/details-journey.dart';
import 'package:flutter/material.dart';

class JourneyTile extends StatelessWidget {
  final Journey journey;

  const JourneyTile({
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
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return DetailsJourney(journey: journey);
            },
          ));
        },
      ),
    );
  }
}
