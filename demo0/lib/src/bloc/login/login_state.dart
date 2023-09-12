part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({required this.count});
  final int count;

  LoginState copyWith({int? count}) {
    return LoginState(count: count ?? this.count);
  }

  @override
  List<Object> get props => [count];
}
