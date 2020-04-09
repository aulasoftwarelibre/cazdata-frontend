import 'package:cazdata_frontend/ui/widget/textfield.widget.dart';
import 'package:flutter/material.dart';

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