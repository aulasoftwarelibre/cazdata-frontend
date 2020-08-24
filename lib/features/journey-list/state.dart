import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:flutter/material.dart';

@immutable
class HunterJourneysState {
  final JourneysList journeysList;
  final bool isLoading;
  final bool errorLoading;

  const HunterJourneysState({@required this.journeysList, @required this.isLoading, @required this.errorLoading});

  factory HunterJourneysState.initial() {
    return new HunterJourneysState(journeysList: new JourneysList(), isLoading: false, errorLoading: false);
  }

  HunterJourneysState copyWith({JourneysList journeysList, bool isLoading, bool errorLoading}) {
    return new HunterJourneysState(
        journeysList: journeysList ?? this.journeysList,
        isLoading: isLoading ?? this.isLoading,
        errorLoading: errorLoading ?? this.errorLoading);
  }
}
