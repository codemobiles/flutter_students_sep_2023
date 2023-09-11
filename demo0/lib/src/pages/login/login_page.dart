import 'package:demo0/src/constants/asset.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            padding: const EdgeInsets.only(top: 20.0, left: 30, right: 30),
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [Text("1234")],
              ),
            ),
          )
        ],
      ),
    );
  }
}
