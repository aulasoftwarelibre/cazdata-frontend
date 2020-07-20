import 'package:cazdata_frontend/model/animal.dart';
import 'package:cazdata_frontend/model/hunted-animal.dart';
import 'package:cazdata_frontend/model/journey.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppState {
  final FirebaseState firebaseState;
  final bool userIsNew;
  final AnimalsListState animalsListState;
  final CurrentJourneyState currentJourneyState;

  const AppState({
    @required this.firebaseState,
    @required this.userIsNew,
    @required this.animalsListState,
    @required this.currentJourneyState,
  });

  factory AppState.initial() {
    return AppState(
      firebaseState: FirebaseState.initial(),
      userIsNew: false,
      animalsListState: AnimalsListState.initial(),
      currentJourneyState: CurrentJourneyState.initial(),
    );
  }

  AppState copyWith(
      {FirebaseState firebaseState,
      bool userIsNew,
      AnimalsListState animalsListState,
      CurrentJourneyState currentJourneyState}) {
    return new AppState(
        firebaseState: firebaseState ?? this.firebaseState,
        userIsNew: userIsNew ?? this.userIsNew,
        animalsListState: animalsListState ?? this.animalsListState,
        currentJourneyState: currentJourneyState ?? this.currentJourneyState);
  }
}

@immutable
class FirebaseState {
  final FirebaseUser firebaseUser;
  final String idTokenUser;

  const FirebaseState(
      {@required this.firebaseUser, @required this.idTokenUser});

  factory FirebaseState.initial() {
    return new FirebaseState(firebaseUser: null, idTokenUser: null);
  }

  FirebaseState copyWith({FirebaseUser firebaseUser, String idTokenUser}) {
    return new FirebaseState(
        firebaseUser: firebaseUser ?? this.firebaseUser,
        idTokenUser: idTokenUser ?? this.idTokenUser);
  }
}

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

@immutable
class CurrentJourneyState {
  final Journey journey;
  final List<Animal> selectedAnimals;
  final List<HuntedAnimal> huntedAnimals;
  final List<LatLng> polylineCoordinates;

  const CurrentJourneyState(
      {@required this.journey,
      @required this.selectedAnimals,
      @required this.huntedAnimals,
      @required this.polylineCoordinates});

  factory CurrentJourneyState.initial() {
    return new CurrentJourneyState(
        journey: null,
        selectedAnimals: [],
        huntedAnimals: [],
        polylineCoordinates: []);
  }

  CurrentJourneyState copyWith(
      {Journey journey,
      List<Animal> selectedAnimals,
      List<HuntedAnimal> huntedAnimals,
      List<LatLng> polylineCoordinates}) {
    return new CurrentJourneyState(
        journey: journey ?? this.journey,
        selectedAnimals: selectedAnimals ?? this.selectedAnimals,
        huntedAnimals: huntedAnimals ?? this.huntedAnimals,
        polylineCoordinates: polylineCoordinates ?? this.polylineCoordinates);
  }
}
