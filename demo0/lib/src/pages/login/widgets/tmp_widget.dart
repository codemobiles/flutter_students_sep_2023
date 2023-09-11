import 'package:flutter/material.dart';

class TmpWidget extends StatefulWidget {
  const TmpWidget({super.key});

  @override
  State<TmpWidget> createState() => _TmpWidgetState();
}

class _TmpWidgetState extends State<TmpWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Container(
        width: double.infinity,
        color: Colors.red.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: MyBox(title: "Box1")),
            Expanded(child: MyBox(title: "Box2", color: Colors.yellow)),
            Expanded(child: MyBox(title: "Box3", color: Colors.orange)),
            Expanded(child: MyBox(title: "Box4", color: Colors.blue)),
            Expanded(child: MyBox(title: "Box5", color: Colors.green)),
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
      alignment: Alignment.center,
      color: color ?? Colors.pink,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
