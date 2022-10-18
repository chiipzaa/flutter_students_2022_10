import 'package:flutter/material.dart';
import 'package:flutter1/src/bloc/home/home_bloc.dart';
import 'package:flutter1/src/bloc/login/login_bloc.dart';
import 'package:flutter1/src/pages/app_routes.dart';
import 'package:flutter1/src/pages/home/home_page.dart';
import 'package:flutter1/src/pages/login/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


final formatCurrency = NumberFormat('#,###.00');
final formatNumber = NumberFormat('#,###');
final navigatorState = GlobalKey<NavigatorState>();

class CMApp extends StatelessWidget {
  const CMApp({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider<HomeBloc>(create: (context) => HomeBloc());
    final loginBloc = BlocProvider<LoginBloc>(create: (context) => LoginBloc());
    
    return MultiBlocProvider(
      providers: [homeBloc,loginBloc],
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorState,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: AppRoute.all,
        home: LoginPage(),
      ),
    );
  }
}
