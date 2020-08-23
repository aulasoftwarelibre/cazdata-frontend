

import 'package:cazdata_frontend/animal/model/animal.dart';
import 'package:flutter/material.dart';

@immutable
class AnimalsListState {
  final List<Animal> animals;
  final bool isLoading;
  final bool errorLoading;

  const AnimalsListState(
      {@required this.animals,
      @required this.isLoading,
      @required this.errorLoading});

  factory AnimalsListState.initial() {
    return new AnimalsListState(
        animals: null, isLoading: false, errorLoading: false);
  }

  AnimalsListState copyWith(
      {List<Animal> animals, bool isLoading, bool errorLoading}) {
    return new AnimalsListState(
        animals: animals ?? this.animals,
        isLoading: isLoading ?? this.isLoading,
        errorLoading: errorLoading ?? this.errorLoading);
  }
}