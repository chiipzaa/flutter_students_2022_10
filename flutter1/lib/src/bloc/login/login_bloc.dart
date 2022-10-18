import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/User.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    // Register
    on<LoginEvent_Register>((event, emit) {
      print("Register: " + event.payload.username + "," + event.payload.password);
    });

    // Login
    on<LoginEvent_Login>((event, emit) {
      print("Register: " + event.payload.username + "," + event.payload.password);
    });
  }
}
