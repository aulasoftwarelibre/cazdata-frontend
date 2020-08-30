import 'package:cazdata_frontend/models/modality/modality.dart';
import 'package:flutter/material.dart';

@immutable
class ModalitiesListState {
  final List<Modality> modalities;
  final bool isLoading;
  final bool errorLoading;

  const ModalitiesListState({@required this.modalities, @required this.isLoading, @required this.errorLoading});

  factory ModalitiesListState.initial() {
    return new ModalitiesListState(modalities: null, isLoading: false, errorLoading: false);
  }

  ModalitiesListState copyWith({List<Modality> modalities, bool isLoading, bool errorLoading}) {
    return new ModalitiesListState(
        modalities: modalities ?? this.modalities,
        isLoading: isLoading ?? this.isLoading,
        errorLoading: errorLoading ?? this.errorLoading);
  }
}
