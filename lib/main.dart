import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/di/service_locator.dart';
import 'package:flutter_application_1/presentation/my_app.dart';
import 'package:intl/date_symbol_data_local.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setPreferredOrientations();
  await initializeDateFormatting('vi_VN');
  await ServiceLocator.configureDependencies();
  runApp(MyApp());
}


Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
