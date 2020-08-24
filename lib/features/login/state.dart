import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class FirebaseState {
  final FirebaseUser firebaseUser;
  final String idTokenUser;

  const FirebaseState({@required this.firebaseUser, @required this.idTokenUser});

  factory FirebaseState.initial() {
    return new FirebaseState(firebaseUser: null, idTokenUser: null);
  }

  FirebaseState copyWith({FirebaseUser firebaseUser, String idTokenUser}) {
    return new FirebaseState(
        firebaseUser: firebaseUser ?? this.firebaseUser, idTokenUser: idTokenUser ?? this.idTokenUser);
  }
}
