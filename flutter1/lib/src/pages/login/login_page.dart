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
            const Expanded(
              child: SingleChildScrollView(
                child: LoginForm(),
              ),
            )
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
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _usernameController.text = "admin";
    _passwordController.text = "1234";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24,
        top: 32,
      ),
      child: Card(
        elevation: 7,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Username
                TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'codemobiles@gmail.com',
                      labelText: 'Username',
                      icon: Icon(Icons.email),
                    )),
                // Password
                TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      labelText: 'Password',
                      icon: Icon(Icons.password),
                    )),

                const SizedBox(height: 32),
                // Login button
                ElevatedButton(onPressed: () => print("Clicked: Login ${_usernameController.text}"), child: Text("Login")),
                OutlinedButton(onPressed: () => print("Clicked: Register"), child: Text("Register")),
                TextButton(onPressed: () {}, child: Text("Clear")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
