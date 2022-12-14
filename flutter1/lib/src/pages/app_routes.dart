import 'package:flutter/cupertino.dart';
import 'package:flutter1/src/pages/home/home_page.dart';
import 'package:flutter1/src/pages/login/login_page.dart';
import 'package:flutter1/src/pages/management/management_page.dart';
import 'package:flutter1/src/pages/map/MapPage.dart';

class AppRoute {
  static const home = 'home';
  static const login = 'login';
  static const management = 'management';
  static const map = 'map';

  static get all => <String, WidgetBuilder>{
        login: (context) => const LoginPage(), // demo how to used widget
        home: (context) => const HomePage(
              title: 'CodeMobiles',
            ),
        management: (context) => const ManagementPage(),
        map: (context) => const MapPage()
      };
}
