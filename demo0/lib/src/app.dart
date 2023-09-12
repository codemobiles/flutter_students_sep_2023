import 'package:demo0/src/bloc/login/login_bloc.dart';
import 'package:demo0/src/pages/app_routes.dart';
import 'package:demo0/src/pages/home/home_page.dart';
import 'package:demo0/src/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/network_api.dart';

final formatCurrency = NumberFormat('#,###.000');
final formatNumber = NumberFormat('#,###');
final navigatorState = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider(create: (context) => LoginBloc());

    return MultiBlocProvider(
      providers: [loginBloc],
      child: MaterialApp(
        title: "CMApp",
        navigatorKey: navigatorState,
        routes: AppRoute.all,
        home: _initialPage(),
      ),
    );
  }

  _initialPage() {
    // final prefs = await SharedPreferences.getInstance();
    // return LoginPage();

    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading...");
        } else {
          final prefs = snapshot.data!;
          final token = prefs.getString(NetworkAPI.token);
          if (token != null) {
            return HomePage();
          } else {
            return LoginPage();
          }
        }
      },
    );
  }
}
