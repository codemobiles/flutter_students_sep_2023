import 'package:demo0/src/pages/app_routes.dart';
import 'package:demo0/src/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
      child: MaterialApp(
        title: "CMApp",
        routes: AppRoute.all,
        home: LoginPage(),
      ),
    );
  }
}
