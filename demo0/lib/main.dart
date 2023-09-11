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
        width: double.infinity,
        color: Colors.red.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyBox(title: "Box1", color: Colors.green),
            MyBox(title: "Box2", color: Colors.yellow),
            MyBox(title: "Box3", color: Colors.orange),
          ],
        ),
      ),
    );
  }
}

class MyBox extends StatelessWidget {
  const MyBox({required this.title, super.key, this.color});

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Text(
        title,
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }
}
