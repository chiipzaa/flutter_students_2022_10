import 'package:flutter/material.dart';
import 'package:flutter1/src/constants/asset.dart';
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Image.asset(
                  Asset.logoImage,
                  width: double.infinity,
                ),
              ),
            ),
            LoginForm()
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24,
        top: 32,
      ),
      child: Card(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Username
                const TextField(
                    decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'codemobiles@gmail.com',
                  labelText: 'Username',
                  icon: Icon(Icons.email),
                )),
                // Password
                const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      labelText: 'Password',
                      icon: Icon(Icons.password),
                    )),
                // Login button
                ElevatedButton(onPressed: () {}, child: Text("Login")),
                ElevatedButton(onPressed: () {}, child: Text("Register")),
                ElevatedButton(onPressed: () {}, child: Text("Clear")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
