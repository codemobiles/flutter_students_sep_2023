import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState(count: 0)) {
    // Add Event
    on<LoginEventAdd>((event, emit) {
      emit(state.copyWith(count: state.count + 1));
    });

    // Remove Event
    on<LoginEventRemove>((event, emit) {
      emit(state.copyWith(count: state.count - 1));
    });
  }
}
