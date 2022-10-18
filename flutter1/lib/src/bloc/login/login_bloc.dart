import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/src/app.dart';
import 'package:flutter1/src/pages/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_setting.dart';
import '../../models/User.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    // Register
    on<LoginEvent_Register>((event, emit) {
      print("Register: " + event.payload.username + "," + event.payload.password);
    });

    on<LoginEvent_Logout>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.pushReplacementNamed(navigatorState.currentContext!, AppRoute.login);
    });

    // Login
    on<LoginEvent_Login>((event, emit) async {
      final String username = event.payload.username;
      final String password = event.payload.password;

      if (username == 'admin' && password == '1234') {
        // method 2
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppSetting.token, 'TExkgk0494oksrkf');
        await prefs.setString(AppSetting.username, username);
        Navigator.pushReplacementNamed(navigatorState.currentContext!, AppRoute.home);
        // Emit
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(state.copyWith(status: LoginStatus.failed));
      }
    });
  }
}
