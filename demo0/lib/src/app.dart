import 'package:demo0/src/bloc/home/home_bloc.dart';
import 'package:demo0/src/bloc/login/login_bloc.dart';
import 'package:demo0/src/bloc/map/map_bloc.dart';
import 'package:demo0/src/pages/app_routes.dart';
import 'package:demo0/src/pages/home/home_page.dart';
import 'package:demo0/src/pages/loading/loading_page.dart';
import 'package:demo0/src/pages/login/login_page.dart';
import 'package:demo0/src/pages/map/map_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/management/management_bloc.dart';
import 'constants/network_api.dart';

final formatCurrency = NumberFormat('#,###.000');
final formatNumber = NumberFormat('#,###');
final navigatorState = GlobalKey<NavigatorState>();

// https://pub.dev/packages/logger
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    colors: true,
  ),
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // log level v,d,i,e,n
    if (kReleaseMode) {
      Logger.level = Level.nothing;
    } else {
      Logger.level = Level.debug;
    }

    final loginBloc = BlocProvider(create: (context) => LoginBloc());
    final homeBloc = BlocProvider(create: (context) => HomeBloc());
    final managementBloc = BlocProvider(create: (context) => ManagementBloc());
    final mapBloc = BlocProvider(create: (context) => MapBloc());

    return MultiBlocProvider(
      providers: [
        loginBloc,
        homeBloc,
        managementBloc,
        mapBloc,
      ],
      child: MaterialApp(
        title: "CMApp",
        navigatorKey: navigatorState,
        routes: AppRoute.all,
        home: _initialPage(),
      ),
    );
  }

  Future<SharedPreferences> _getPref() async {
    await Future.delayed(const Duration(seconds: 1));
    return SharedPreferences.getInstance();
  }

  _initialPage() {
    // final prefs = await SharedPreferences.getInstance();
    // return LoginPage();

    return FutureBuilder(
      future: _getPref(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoadingPage();
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
