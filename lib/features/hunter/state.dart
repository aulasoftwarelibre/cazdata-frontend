import 'package:cazdata_frontend/models/hunter/hunter.dart';
import 'package:flutter/material.dart';

@immutable
class HunterState {
  final Hunter hunter;

  const HunterState({
    @required this.hunter,
  });

  factory HunterState.initial() {
    return new HunterState(
      hunter: null,
    );
  }

  HunterState copyWith({Hunter hunter, bool isNew}) {
    return new HunterState(
      hunter: hunter ?? this.hunter,
    );
  }
}
