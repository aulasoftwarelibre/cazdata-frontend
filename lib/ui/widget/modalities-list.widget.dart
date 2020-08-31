import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:cazdata_frontend/models/modality/modality.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModalitiesListWidget extends StatefulWidget {
  final Journey journey;
  final Function(String) update;

  ModalitiesListWidget(this.journey, this.update);

  @override
  _ModalitiesListWidgetState createState() => _ModalitiesListWidgetState();
}

class _ModalitiesListWidgetState extends State<ModalitiesListWidget> {
  final _dropdownButtonFormFieldKey = GlobalKey<FormFieldState>();
  Widget _modalities;

  @override
  Widget build(BuildContext context) {
    if (_modalities == null) {
      // Create the form if it does not exist
      _modalities = _createModalitiesButton(context); // Build the form
    }
    return _modalities; // Show the form in the application
  }

  _createModalitiesButton(BuildContext context) {
    final Query modalities = FirebaseFirestore.instance.collection('modalities');

    return StreamBuilder<QuerySnapshot>(
        stream: modalities.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error al leer las jornadas");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return DropdownButtonFormField(
            key: _dropdownButtonFormFieldKey,
            value: this.widget.journey.modality,
            icon: Icon(Icons.arrow_drop_down),
            decoration: InputDecoration(
              labelText: 'Modalidad',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            items: _getHuntModalities(snapshot.data),
            validator: _validateModality,
            onChanged: (modality) {
              this.widget.update(modality);
            },
            onSaved: (modality) {
              this.widget.update(modality);
            },
          );
        });
  }

  List<DropdownMenuItem<String>> _getHuntModalities(QuerySnapshot snapshot) {
    final modalitiesDocuments = snapshot.docs;
    final modalitiesList = ModalitiesList.fromFirestoreDocuments(modalitiesDocuments);

    return modalitiesList.modalities.map((modality) {
      return DropdownMenuItem<String>(
        value: modality.name,
        child: Text(
          modality.name,
        ),
      );
    }).toList();
  }

  String _validateModality(String modality) {
    if (modality == null) {
      return 'Seleccione una modalidad para la jornada';
    }
    return null;
  }
}
