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

  LoginState copyWith({
    int? count,
    LoginStatus? status,
    String? dialogMessage,
  }) {
    return LoginState(
      count: count ?? this.count,
      status: status ?? this.status,
      dialogMessage: dialogMessage ?? this.dialogMessage,
    );
  }

  @override
  List<Object> get props => [count, status, dialogMessage];
}
