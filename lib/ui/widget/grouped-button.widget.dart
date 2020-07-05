//library custom_radio_grouped_button;
import 'package:cazdata_frontend/model/animal.dart';
import 'package:flutter/material.dart';

class CustomCheckBoxGroup extends StatefulWidget {
  CustomCheckBoxGroup({
    this.buttonLables,
    this.fontSize = 15,
    this.buttonValuesList,
    this.checkBoxButtonValues,
    this.buttonColor,
    this.selectedColor,
    this.height = 25,
    this.width = 100,
    this.autoWidth = true,
    this.defaultSelected,
    this.padding = 2,
    this.horizontal = false,
    this.enableShape = false,
    this.elevation = 0,
    this.customShape,
  })  : assert(buttonLables.length == buttonValuesList.length),
        assert(buttonColor != null),
        // assert(defaultSelected != null
        // ? buttonValuesList.contains(defaultSelected) != false
        // : true),
        assert(selectedColor != null);

  final bool horizontal;

  final List buttonValuesList;
  final double fontSize;

  final double height;
  final double padding;

  ///Only applied when in vertical mode
  final bool autoWidth;
  final double width;
  final bool enableShape;
  final double elevation;

  final List<Animal> buttonLables;

  final Function(List<dynamic>) checkBoxButtonValues;

  final Color selectedColor;
  final dynamic defaultSelected;

  final Color buttonColor;
  final ShapeBorder customShape;

  _CustomCheckBoxGroupState createState() => _CustomCheckBoxGroupState();
}

class _CustomCheckBoxGroupState extends State<CustomCheckBoxGroup> {
  List<dynamic> selectedLables = [];

  @override
  void initState() {
    super.initState();
    selectedLables.add(widget.defaultSelected);
    // currentSelectedLabel = widget.buttonLables[0];
  }

  List<Widget> buildButtonsColumn() {
    List<Widget> buttons = [];
    for (int index = 0; index < widget.buttonLables.length; index++) {
      var button = Padding(
        padding: EdgeInsets.all(widget.padding),
        child: Card(
          color: selectedLables.contains(widget.buttonValuesList[index])
              ? widget.selectedColor
              : widget.buttonColor,
          elevation: widget.elevation,
          shape: widget.enableShape
              ? widget.customShape == null
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    )
                  : widget.customShape
              : null,
          child: Container(
            height: widget.height,
            child: MaterialButton(
              shape: widget.enableShape
                  ? widget.customShape == null
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        )
                      : widget.customShape
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1),
                      borderRadius: BorderRadius.zero,
                    ),
              onPressed: () {
                if (selectedLables.contains(widget.buttonValuesList[index])) {
                  selectedLables.remove(widget.buttonValuesList[index]);
                } else {
                  selectedLables.add(widget.buttonValuesList[index]);
                }
                setState(() {});
                widget.checkBoxButtonValues(selectedLables);
              },
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage("assets/google_logo.png"),
                    backgroundColor: Colors.transparent,
                  ),
                  Expanded(
                    child: Text(
                      widget.buttonLables[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: selectedLables
                                .contains(widget.buttonValuesList[index])
                            ? Colors.white
                            : Theme.of(context).textTheme.bodyText1.color,
                        fontSize: widget.fontSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      buttons.add(button);
    }
    return buttons;
  }

  List<Widget> buildButtonsRow() {
    List<Widget> buttons = [];
    for (int index = 0; index < widget.buttonLables.length; index++) {
      var button = Card(
        color: selectedLables.contains(widget.buttonValuesList[index])
            ? widget.selectedColor
            : widget.buttonColor,
        elevation: widget.elevation,
        shape: widget.enableShape
            ? widget.customShape == null
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  )
                : widget.customShape
            : null,
        child: Container(
          height: widget.height,
          width: widget.autoWidth ? null : widget.width,
          constraints: BoxConstraints(maxWidth: 250),
          decoration: BoxDecoration(),
          child: MaterialButton(
            shape: widget.enableShape
                ? widget.customShape == null
                    ? OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )
                    : widget.customShape
                : OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                    borderRadius: BorderRadius.zero,
                  ),
            onPressed: () {
              if (selectedLables.contains(widget.buttonValuesList[index])) {
                selectedLables.remove(widget.buttonValuesList[index]);
              } else {
                selectedLables.add(widget.buttonValuesList[index]);
              }
              setState(() {});
              widget.checkBoxButtonValues(selectedLables);
            },
            child: Text(
              widget.buttonLables[index].name,
              style: TextStyle(
                color: selectedLables.contains(widget.buttonValuesList[index])
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyText1.color,
                fontSize: widget.fontSize,
              ),
            ),
          ),
        ),
        // ),
      );
      buttons.add(button);
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: widget.horizontal
            ? GridView.count(
                crossAxisCount: 2,
                childAspectRatio: ((MediaQuery.of(context).size.width / 1.14) /
                    (MediaQuery.of(context).size.width / 2.99)),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: buildButtonsColumn(),
              )
            : ListView(
                scrollDirection: Axis.horizontal,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buildButtonsRow(),
              ),
      ),
    );
  }
}
