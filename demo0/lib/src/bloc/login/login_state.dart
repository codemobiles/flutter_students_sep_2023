part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({required this.count});
  final int count;

  LoginState copyWith() {
    return LoginState(count: count);
  }

  @override
  List<Object> get props => [];
}
