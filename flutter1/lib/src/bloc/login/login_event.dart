part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginEvent_Register extends LoginEvent {
  final User payload;
  LoginEvent_Register(this.payload);
}

class LoginEvent_Login extends LoginEvent {
  final User payload;
  LoginEvent_Login(this.payload);
}


class LoginEvent_Logout extends LoginEvent {
}
