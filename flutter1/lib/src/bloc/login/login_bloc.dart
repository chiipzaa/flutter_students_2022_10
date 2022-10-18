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
      final String username = event.payload.username;
      final String password = event.payload.password;

      if (username == 'admin' && password == '1234') {
        // method 2
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppSetting.token, 'TExkgk0494oksrkf');
        await prefs.setString(AppSetting.username, username);
        Navigator.pushReplacementNamed(navigatorState.currentContext!, AppRoute.home_v2);
        // Emit
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        print("Login failed");
      }


    });
  }
}
