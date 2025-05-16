import 'package:event_bus/event_bus.dart';
import 'package:flutter_application_1/data/network/api/api_create_exp.dart';
import 'package:flutter_application_1/data/network/api/api_login.dart';
import 'package:flutter_application_1/data/network/api/api_register.dart';
import 'package:flutter_application_1/data/network/rest_client.dart';
import 'package:flutter_application_1/data/sharedpref/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/service_locator.dart';

class NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // event bus:---------------------------------------------------------------
  if (!getIt.isRegistered<SharedPreferenceHelper>()) {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferenceHelper>(
    SharedPreferenceHelper(prefs),
  );
}

    getIt.registerSingleton<EventBus>(EventBus());
    getIt.registerSingleton<RestClient>(RestClient());
    getIt.registerSingleton<ApiLogin>(ApiLogin());
    getIt.registerSingleton<ApiRegister>(ApiRegister());
    getIt.registerSingleton<ApiCreateExp>(ApiCreateExp());


    
}
}
