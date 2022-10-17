import 'package:flutter/material.dart';
import 'package:flutter1/src/pages/login/widgets/cmtext.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Image.asset("assets/images/logo.png", width: double.infinity,),
            CMText(
              "CodeMobiles1",
              color: Colors.yellow,
            ),
            CMText(
              "CodeMobiles2",
              color: Colors.red,
            ),
            CMText(
              "CodeMobiles3",
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
