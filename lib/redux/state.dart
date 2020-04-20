import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppState {
  final FirebaseState firebaseState;
  final bool userIsNew;

  const AppState({
    @required this.firebaseState,
    @required this.userIsNew,
  });

  AppState copyWith({FirebaseState firebaseState}) {
    return new AppState(
        firebaseState: firebaseState ?? this.firebaseState,
        userIsNew: userIsNew ?? this.userIsNew);
  }

  factory AppState.initial() {
    return AppState(
      firebaseState: FirebaseState.initial(),
      userIsNew: false
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
