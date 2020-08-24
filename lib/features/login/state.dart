import 'package:flutter/material.dart';

class LoginState {
  final bool isNew;
  final bool isLogged;

  const LoginState({@required this.isNew, @required this.isLogged});

  factory LoginState.initial() {
    return new LoginState(isNew: false, isLogged: false);
  }

  LoginState copyWith({bool isNew, bool isLogged}) {
    return new LoginState(isNew: isNew ?? this.isNew, isLogged: isLogged ?? this.isLogged);
  }
}
