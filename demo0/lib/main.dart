import 'package:flutter/material.dart';

main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.red,
                child: Text("I am body"),
              ),
            ),
            Text("I am body"),
            Text("I am body"),
          ],
        ),
      ),
    );
  }
}
