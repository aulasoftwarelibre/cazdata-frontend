import 'package:cazdata_frontend/ui/widget/textfield.widget.dart';
import 'package:flutter/material.dart';

class ProfileOnMapWidget extends StatelessWidget {
  const ProfileOnMapWidget({this.name, this.location, this.profilePic});

  final String name;
  final String location;
  final String profilePic;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.brown.shade800,
              child: Text(profilePic),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFieldWidget(header: name, content: location)),
        ],
      ),
    );
  }
}
