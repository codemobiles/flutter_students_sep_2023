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
  var count = 0;

  // Called when widget is created
  @override
  void initState() {
    super.initState();

    // Initial your application data
    _usernameController.text = "lek";
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
                    OutlinedButton(onPressed: _handleRegister, child: Text("Register")),
                    // Counter
                    _buildCounter()
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
    final username = _usernameController.text;
    final password = _passwordController.text;
    print("Username: $username, Password: $password");

    Navigator.pushNamed(context, "home");
  }

  void _handleRegister() {}

  _buildCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              setState(() {
                count--;
              });
              print("-- count: $count");
            },
            child: Icon(Icons.remove)),
        Text("$count"),
        TextButton(
            onPressed: () {
              count++;
              setState(() {});
              print("++ count: $count");
            },
            child: Icon(Icons.add)),
      ],
    );
  }
}
