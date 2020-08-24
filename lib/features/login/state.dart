import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class LoginState {
  final FirebaseUser firebaseUser;
  final bool isNew;

  const LoginState({@required this.firebaseUser, @required this.isNew});

  factory LoginState.initial() {
    return new LoginState(firebaseUser: null, isNew: false);
  }

  LoginState copyWith({FirebaseUser firebaseUser, bool isNew}) {
    return new LoginState(firebaseUser: firebaseUser ?? this.firebaseUser, isNew: isNew ?? this.isNew);
  }
}
