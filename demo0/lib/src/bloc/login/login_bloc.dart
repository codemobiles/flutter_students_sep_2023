import 'package:bloc/bloc.dart';
import 'package:demo0/src/app.dart';
import 'package:demo0/src/constants/network_api.dart';
import 'package:demo0/src/models/user.dart';
import 'package:demo0/src/pages/app_routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(const LoginState(
          count: 0,
          status: LoginStatus.init,
          dialogMessage: "",
        )) {
    // Add Event
    on<LoginEventAdd>((event, emit) {
      emit(state.copyWith(count: state.count + 1));
    });

    // Remove Event
    on<LoginEventRemove>((event, emit) {
      emit(state.copyWith(count: state.count - 1));
    });

    // Login Event
    on<LoginEventLogin>((event, emit) async {
      final String username = event.user.username;
      final String password = event.user.password;

      // Update status to fetching
      emit(state.copyWith(status: LoginStatus.fetching));

      await Future.delayed(const Duration(seconds: 2));

      if (username == 'admin' && password == '1234') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(NetworkAPI.token, 'TExkgk0494oksrkf');
        await prefs.setString(NetworkAPI.username, username);

        // Emit
        emit(state.copyWith(status: LoginStatus.success));

        Navigator.pushReplacementNamed(
            navigatorState.currentContext!, AppRoute.home);

        // hideKeyboard();
      } else {
        print("Login failed");
        emit(state.copyWith(
            dialogMessage: "Login failed", status: LoginStatus.failed));

        emit(state.copyWith(dialogMessage: ""));
      }
    });
  }
}
