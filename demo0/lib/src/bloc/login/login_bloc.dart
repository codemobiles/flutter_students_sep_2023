import 'package:bloc/bloc.dart';
import 'package:demo0/src/models/user.dart';
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

    // Login Event
    on<LoginEventLogin>((event, emit) {

      final String username = event.payload.username;
      final String password = event.payload.password;

      if (username == 'admin' && password == '1234') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(NetworkAPI.token, 'TExkgk0494oksrkf');
        await prefs.setString(NetworkAPI.username, username);
        Navigator.pushReplacementNamed(
            navigatorState.currentContext!, AppRoute.home);
        // Emit
        emit(state.copyWith(status: LoginStatus.success));
        hideKeyboard();
      } else {
        print("Login failed");
        emit(state.copyWith(
            dialogMessage: "Login failed", status: LoginStatus.failed));
        await Future.delayed(Duration(milliseconds: 100));
        emit(state.copyWith(dialogMessage: ""));
      }

      
    });
  }
}
