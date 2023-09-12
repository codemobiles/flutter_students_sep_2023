import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState(count: 99)) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
