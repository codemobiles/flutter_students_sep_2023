part of 'login_bloc.dart';

enum LoginStatus { fetching, success, failed, init }

class LoginState extends Equatable {
  const LoginState({
    required this.count,
    required this.status,
    required this.dialogMessage,
  });
  final int count;
  final LoginStatus status;
  final String dialogMessage;

  LoginState copyWith({int? count}) {
    return LoginState(count: count ?? this.count);
  }

  @override
  List<Object> get props => [count];
}
