part of 'login_bloc.dart';

// Add Counter
abstract class LoginEvent {}

// Add Counter
class LoginEventAdd extends LoginEvent {}

// Remove Counter
class LoginEventRemove extends LoginEvent {}

// Login
class LoginEventLogin extends LoginEvent {
  final User user;
  LoginEventLogin(this.user);
}
