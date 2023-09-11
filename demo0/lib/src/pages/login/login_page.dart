import 'package:demo0/src/constants/asset.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LoginPage"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          SizedBox(height: 110, width: double.infinity, child: Image.asset(Asset.logoImage)),
          // login box
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 30, right: 30),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Username
                    TextField(
                      controller: _usernameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        labelText: 'Password',
                        icon: Icon(Icons.password),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Login button
                    ElevatedButton(onPressed: _handleLogin, child: Text("Login")),
                    // Register button
                    OutlinedButton(onPressed: _handleRegister, child: Text("Register"))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleLogin() {
    print("Username: ${_usernameController.text}, Password: ${_passwordController.text}");
  }

  void _handleRegister() {}
}
