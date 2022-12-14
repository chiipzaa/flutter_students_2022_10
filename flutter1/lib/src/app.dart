import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/src/bloc/home/home_bloc.dart';
import 'package:flutter1/src/bloc/login/login_bloc.dart';
import 'package:flutter1/src/bloc/management/management_bloc.dart';
import 'package:flutter1/src/constants/app_setting.dart';
import 'package:flutter1/src/pages/app_routes.dart';
import 'package:flutter1/src/pages/home/home_page.dart';
import 'package:flutter1/src/pages/login/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/map/map_bloc.dart';

final formatCurrency = NumberFormat('#,###.00');
final formatNumber = NumberFormat('#,###');
final navigatorState = GlobalKey<NavigatorState>();

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    colors: true,
  ),
);

final loggerNoStack = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    colors: true,
  ),
);



class CMApp extends StatelessWidget {
  const CMApp({super.key});

  @override
  Widget build(BuildContext context) {

    if (kReleaseMode) {
      Logger.level = Level.nothing;
    } else {
      Logger.level = Level.debug;
    }

    final homeBloc = BlocProvider<HomeBloc>(create: (context) => HomeBloc());
    final loginBloc = BlocProvider<LoginBloc>(create: (context) => LoginBloc());
    final managementBloc = BlocProvider<ManagementBloc>(create: (context) => ManagementBloc());
    final mapBloc = BlocProvider<MapBloc>(create: (context) => MapBloc());

    return MultiBlocProvider(
      providers: [
        homeBloc,
        loginBloc,
        managementBloc,
        mapBloc,
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        navigatorKey: navigatorState,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: AppRoute.all,
        home: _loadInitialPage(),
      ),
    );
  }

  _loadInitialPage() {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: Colors.white,
          );
        }
        final token = snapshot.data!.getString(AppSetting.token) ?? "";
        return token.isNotEmpty ? const HomePage(title: "CodeMobiles") : const LoginPage();
      },
    );
  }
}
