import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/calendar_screen.dart';
import 'package:flutter_application_1/presentation/pages/home_screen.dart';
import 'package:flutter_application_1/presentation/pages/login_screen.dart';
import 'package:flutter_application_1/presentation/pages/main_bottom_screen.dart';
import 'package:flutter_application_1/presentation/pages/setting_screen.dart';
import 'package:flutter_application_1/presentation/pages/signup_screen.dart';
import 'package:flutter_application_1/presentation/pages/statistical_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String login = '/login';
  static const String home = '/home';
  static const String signup = '/signup';
  static const String calendar = '/calendar';
  static const String statistical = '/statistical';
  static const String setting = '/setting';
  static const String mainBottom = '/mainBottom';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    signup: (BuildContext context) => SignupScreen(),
    calendar: (BuildContext context) => CalendarScreen(),
    statistical: (BuildContext context) => StatisticalScreen(),
    setting: (BuildContext context) => SettingScreen(),
    mainBottom: (BuildContext context) => MainBottomScreen(),
  };
}
