import 'package:cazdata_frontend/model/animal.dart';
import 'package:flutter/material.dart';

class AnimalTile extends StatelessWidget {

  final Animal animal;

  const AnimalTile({
    this.animal,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
          child: ListTile(
            title: Text(this.animal.name),
            onTap: (){
              //Do something
            },
          ),
    );
  }
}
