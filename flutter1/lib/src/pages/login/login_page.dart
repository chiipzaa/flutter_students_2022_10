import 'package:flutter/material.dart';
import 'package:flutter1/src/bloc/login/login_bloc.dart';
import 'package:flutter1/src/constants/asset.dart';
import 'package:flutter1/src/models/User.dart';
import 'package:flutter1/src/pages/app_routes.dart';
import 'package:flutter1/src/pages/login/widgets/cmtext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                ElevatedButton(onPressed: _handleLogin, child: Text("Login")),
                OutlinedButton(onPressed: _handleRegister, child: Text("Register")),
                TextButton(onPressed: _handlerClear, child: Text("Clear")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    // Navigator.pushNamed(context, AppRoute.home);
    // Navigator.pushReplacementNamed(context, AppRoute.home);
    final username = _usernameController.text;
    final password = _passwordController.text;
    context.read<LoginBloc>().add(LoginEvent_Login(User(username, password)));
  }

  void _handleRegister() {
  }

  void _handlerClear() {
    _usernameController.text = "";
    _passwordController.text = "";
  }
}
