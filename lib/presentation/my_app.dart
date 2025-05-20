import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/string.dart';
import 'package:flutter_application_1/presentation/pages/login_screen.dart';
import 'package:flutter_application_1/presentation/pages/main_bottom_screen.dart';
import 'package:flutter_application_1/presentation/store/login_store.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // <-- Thêm dòng này
import '../di/service_locator.dart';

class MyApp extends StatelessWidget {
  final UserStore _userStore = getIt<UserStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.appName,
          theme: ThemeData.dark(), 
          routes: Routes.routes,
          home: _userStore.isLoggedIn ? MainBottomScreen() : LoginScreen(),

          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('vi', 'VN'),
            Locale('en', 'US'),
          ],
        );
      },
    );
  }
}
