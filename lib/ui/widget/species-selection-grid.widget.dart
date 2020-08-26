import 'package:cazdata_frontend/models/animal/animal.dart';
import 'package:cazdata_frontend/ui/widget/checkbox-image-button.widget.dart';
import 'package:flutter/material.dart';

class SpeciesSelectionGrid extends StatefulWidget {
  SpeciesSelectionGrid({
    this.buttonLabels,
    this.buttonValuesList,
    this.checkBoxButtonValues,
  }) : assert(buttonLabels.length == buttonValuesList.length);

  final List buttonValuesList;
  final List<dynamic> buttonLabels;
  final Function(List<Animal>) checkBoxButtonValues;

  _SpeciesSelectionGridState createState() => _SpeciesSelectionGridState();
}

class _SpeciesSelectionGridState extends State<SpeciesSelectionGrid> {
  List<Animal> selectedLabels = [];

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _speciesGrid() {
    return widget.buttonLabels.asMap().entries.map((entry) {
      int index = entry.key;
      Animal animal = entry.value;
      bool enabled = selectedLabels.contains(widget.buttonValuesList[index]);

      return CheckboxImageButton(
        enabled: enabled,
        image: animal.contentUrl,
        key: Key(animal.id),
        onPressed: () {
          if (enabled) {
            selectedLabels.remove(widget.buttonValuesList[index]);
          } else {
            selectedLabels.add(widget.buttonValuesList[index]);
          }
          setState(() {});
          widget.checkBoxButtonValues(selectedLabels);
        },
        text: animal.name,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: ((MediaQuery.of(context).size.width / 1.14) / (MediaQuery.of(context).size.width / 2.99)),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: _speciesGrid(),
      ),
    );
  }
}
