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

class AnimalSpecieTile extends StatelessWidget {
  final Animal animal;

  const AnimalSpecieTile({
    this.animal,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(animal.contentUrl),
        ),
        title: Text(this.animal.name),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          _launchURL('https://pub.dev/packages/url_launcher');
        },
      ),
    );
  }
}
