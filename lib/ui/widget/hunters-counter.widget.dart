import 'package:cazdata_frontend/util/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef void CounterChangeCallback(num value);

class HuntersInJourneyCounter extends StatefulWidget {
  HuntersInJourneyCounter({
    Key key,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    this.step = 1,
  })  : assert(minValue != null),
        assert(maxValue != null),
        assert(maxValue > minValue),
        assert(step > 0),
        super(key: key);

  final CounterChangeCallback onChanged;

  ///min value user can pick
  final num minValue;

  ///max value user can pick
  final num maxValue;

  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final num step;

  @override
  _HuntersInJourneyCounterState createState() => _HuntersInJourneyCounterState();
}

class _HuntersInJourneyCounterState extends State<HuntersInJourneyCounter> {
  num selectedValue = 1;

  void _incrementCounter() {
    if (selectedValue + widget.step <= widget.maxValue) {
      selectedValue++;
      widget.onChanged((selectedValue));
    }
  }

  void _decrementCounter() {
    if (selectedValue - widget.step >= widget.minValue) {
      selectedValue--;
      widget.onChanged((selectedValue));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(4.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          new SizedBox(
            width: 40,
            height: 40,
            child: FloatingActionButton(
              onPressed: _decrementCounter,
              heroTag: '-',
              elevation: 2,
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
              backgroundColor: primaryColor,
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: new Text(selectedValue.toString(), style: TextStyle(fontSize: 32)),
          ),
          new SizedBox(
            width: 40,
            height: 40,
            child: FloatingActionButton(
              heroTag: '+',
              onPressed: _incrementCounter,
              elevation: 2,
              tooltip: 'Increment',
              child: Icon(Icons.add),
              backgroundColor: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
