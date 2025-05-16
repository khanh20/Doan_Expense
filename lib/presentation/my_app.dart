import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/string.dart';
import 'package:flutter_application_1/presentation/screen/home_screen.dart';
import 'package:flutter_application_1/presentation/screen/login_screen.dart';
import 'package:flutter_application_1/presentation/screen/main_bottom_screen.dart';
import 'package:flutter_application_1/presentation/store/login_store.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../di/service_locator.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
 
  final UserStore _userStore = getIt<UserStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.appName,
          routes: Routes.routes,
          home: _userStore.isLoggedIn ? MainBottomScreen() : LoginScreen(),
          
        );
      },
    );
  }
}
