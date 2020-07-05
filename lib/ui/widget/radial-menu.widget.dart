import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;

class RadialMenu extends StatefulWidget {
  createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
    // ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({Key key, this.controller})
      : translation = Tween<double>(
          begin: 0.0,
          end: 100.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.elasticOut),
        ),
        scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        rotation = Tween<double>(
          begin: 0.0,
          end: 360.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.7,
              curve: Curves.decelerate,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> rotation;
  final Animation<double> translation;
  final Animation<double> scale;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, widget) {
          return Transform.rotate(
              angle: radians(rotation.value),
              child: Stack(alignment: Alignment.center, children: <Widget>[
                _buildButton(0, color: Colors.brown, icon: Icons.spa),
                _buildButton(45, color: Colors.green, icon: Icons.spa),
                _buildButton(90, color: Colors.brown, icon: Icons.spa),
                _buildButton(135, color: Colors.green, icon: Icons.spa),
                _buildButton(180, color: Colors.brown, icon: Icons.spa),
                _buildButton(225, color: Colors.green, icon: Icons.spa),
                _buildButton(270, color: Colors.brown, icon: Icons.spa),
                _buildButton(315, color: Colors.green, icon: Icons.spa),
                Transform.scale(
                  scale: scale.value - 1,
                  child: FlatButton(
                      child: Icon(Icons.clear),
                      onPressed: _close,
                      shape: CircleBorder(),
                      color: Colors.red),
                ),
                Transform.scale(
                  scale: scale.value,
                  child: FlatButton(
                    child: Icon(Icons.clear),
                    onPressed: _open,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(15.0),
                  ),
                )
              ]));
        });
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }

  _buildButton(double angle, {Color color, IconData icon}) {
    final double rad = radians(angle);
    return Transform(
        transform: Matrix4.identity()
          ..translate(
              (translation.value) * cos(rad), (translation.value) * sin(rad)),
        child: FlatButton(
          child: Icon(icon),
          color: color,
          shape: CircleBorder(),
          padding: EdgeInsets.all(15.0),
          onPressed: _close,
        ));
  }
}
