import 'package:flutter/material.dart';
import 'package:flutter1/src/pages/home/home_page.dart';
import 'package:flutter1/src/pages/login/login_page.dart';

class CMApp extends StatelessWidget {
  const CMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
