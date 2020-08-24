import 'package:cazdata_frontend/models/hunter/hunter.dart';
import 'package:flutter/material.dart';

@immutable
class HunterState {
  final Hunter hunter;
  final bool isNew;

  const HunterState({@required this.hunter, @required this.isNew});

  factory HunterState.initial() {
    return new HunterState(hunter: null, isNew: false);
  }

  HunterState copyWith({Hunter hunter, bool isNew}) {
    return new HunterState(hunter: hunter ?? this.hunter, isNew: isNew ?? this.isNew);
  }
}
