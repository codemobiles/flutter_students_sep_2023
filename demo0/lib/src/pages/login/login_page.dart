import 'package:demo0/src/bloc/login/login_bloc.dart';
import 'package:demo0/src/constants/asset.dart';
import 'package:demo0/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Called when widget is created
  @override
  void initState() {
    super.initState();

    // Initial your application data
    _usernameController.text = "admin";
    _passwordController.text = "1234";
  }

  // Called when widget is destroyed
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LoginPage"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
                height: 110,
                width: double.infinity,
                child: Image.asset(Asset.logoImage)),
            // login box
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 30, right: 30),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Username
                      TextField(
                        controller: _usernameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'codemobiles@gmail.com',
                          labelText: 'Username',
                          icon: Icon(Icons.verified_user),
                        ),
                      ),
                      // Password
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          labelText: 'Password',
                          icon: Icon(Icons.password),
                        ),
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state.status == LoginStatus.failed) {
                            return const Text(
                              "Login failed - invalid username or password",
                              style: TextStyle(color: Colors.red),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      // Login button
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return ElevatedButton(
                              onPressed: (state.status == LoginStatus.fetching)
                                  ? null
                                  : _handleLogin,
                              child: const Text("Login"));
                        },
                      ),
                      // Register button
                      OutlinedButton(
                          onPressed: _handleRegister,
                          child: const Text("Register")),
                      // Counter
                      _buildCounter()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleLogin() {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final user = User(username, password);
    context.read<LoginBloc>().add(LoginEventLogin(user));
  }

  void _handleRegister() {}

  _buildCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              context.read<LoginBloc>().add(LoginEventRemove());
            },
            child: const Icon(Icons.remove)),
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Text("${state.count}");
          },
        ),
        TextButton(
            onPressed: () {
              context.read<LoginBloc>().add(LoginEventAdd());
            },
            child: const Icon(Icons.add)),
      ],
    );
  }
}
