import 'package:cazdata_frontend/model/animal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppState {
  final FirebaseState firebaseState;
  final bool userIsNew;
  final AnimalsListState animalsListState;

  const AppState({
    @required this.firebaseState,
    @required this.userIsNew,
    @required this.animalsListState,
  });

  AppState copyWith(
      {FirebaseState firebaseState, bool userIsNew, AnimalsListState animalsListState}) {
    return new AppState(
        firebaseState: firebaseState ?? this.firebaseState,
        userIsNew: userIsNew ?? this.userIsNew,
        animalsListState: animalsListState ?? this.animalsListState);
  }

  factory AppState.initial() {
    return AppState(
      firebaseState: FirebaseState.initial(),
      userIsNew: false,
      animalsListState: AnimalsListState.initial(),
    );
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
      {@required this.animals, @required this.isLoading, @required this.errorLoading});

  factory AnimalsListState.initial() {
    return new AnimalsListState(animals: null, isLoading: false, errorLoading: false);
  }

  AnimalsListState copyWith({List<Animal> animals, bool isLoading, bool errorLoading}) {
    return new AnimalsListState(
        animals: animals ?? this.animals,
        isLoading: isLoading ?? this.isLoading,
        errorLoading: errorLoading ?? this.errorLoading);
  }
}
