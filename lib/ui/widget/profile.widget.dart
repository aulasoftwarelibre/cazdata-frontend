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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(profilePic),
            backgroundColor: Colors.transparent,
          ),
          Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFieldWidget(header: name, content: location)),
        ],
      ),
    );
  }
}