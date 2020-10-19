import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class AnimalSpecie extends StatelessWidget {
  final Animal animal;

  const AnimalSpecie({
    this.animal,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get attribution_url
    RegExp exp = new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    RegExpMatch match = exp.firstMatch(animal.attribution);
    String attributionUrl = match != null ? animal.attribution.substring(match.start, match.end) : '';
    
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(animal.contentUrl),
        ),
        title: Text(this.animal.name),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          _launchURL(attributionUrl);
        },
      ),
    );
  }
}
