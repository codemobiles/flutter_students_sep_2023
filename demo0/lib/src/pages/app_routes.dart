import 'package:demo0/src/pages/firebase/firebaseauth_page.dart';
import 'package:demo0/src/pages/firebase/firebasestore_page.dart';
import 'package:demo0/src/pages/login/login_page.dart';
import 'package:demo0/src/pages/sqlite/sqlite_page.dart';
import 'package:flutter/material.dart';

import 'firebase/firebaseanalytics_page.dart';
import 'firebase/firebasepush_page.dart';
import 'home/home_page.dart';
import 'loading/loading_page.dart';
import 'management/management_page.dart';
import 'map/map_page.dart';

class AppRoute {
  static const home = 'home';
  static const login = 'login';
  static const management = 'management';
  static const map = 'map';
  static const loading = 'loading';

  // Optional Pages
  static const sqlite = 'sqlite';
  static const firebase_push = 'firebase_push';
  static const firebase_auth = 'firebase_auth';
  static const forget_password = 'forget_password';
  static const firebase_store = 'firebase_store';
  static const firebase_analytics = 'firebase_analytics';

  static get all => <String, WidgetBuilder>{
        login: (context) => const LoginPage(), // demo how to used widget
        home: (context) => const HomePage(),
        management: (context) => const ManagementPage(),
        map: (context) => const MapPage(),
        loading: (context) => const LoadingPage(),
        sqlite: (context) => const SqlitePage(),
        firebase_push: (context) => const FirebasePushNotificationPage(),
        firebase_auth: (context) => const FirebaseAuthPage(),
        firebase_store: (context) => const FirebaseStorePage(),
        firebase_analytics: (context) => const FirebaseAnalyticsPage(),
      };
}
