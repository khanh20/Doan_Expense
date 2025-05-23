import 'dart:async';
import 'package:flutter_application_1/data/network/api/api_create_exp.dart';
import 'package:flutter_application_1/data/network/api/api_get_category.dart';
import 'package:flutter_application_1/data/network/api/api_get_exp.dart';
import 'package:flutter_application_1/data/network/api/api_login.dart';
import 'package:flutter_application_1/data/network/api/api_register.dart';
import 'package:flutter_application_1/data/network/api/api_statistics.dart';
import 'package:flutter_application_1/data/repositories/category_repository_impl.dart';
import 'package:flutter_application_1/data/repositories/exp_repository_impl.dart';
import 'package:flutter_application_1/data/repositories/statistic_repository_impl.dart';
import 'package:flutter_application_1/data/repositories/user/user_repository_impl.dart';
import 'package:flutter_application_1/data/repositories/user/user_signup_impl.dart';
import 'package:flutter_application_1/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_application_1/domain/repositories/category_repository.dart';
import 'package:flutter_application_1/domain/repositories/exp_repository.dart';
import 'package:flutter_application_1/domain/repositories/statistic_repository.dart';
import 'package:flutter_application_1/domain/repositories/user/user_repository.dart';
import 'package:flutter_application_1/domain/repositories/user/user_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/service_locator.dart';



class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    if (!getIt.isRegistered<SharedPreferenceHelper>()) {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferenceHelper>(
    SharedPreferenceHelper(prefs),
  );
}

 
    getIt.registerSingleton<UserRepository>(UserRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
      getIt<ApiLogin>(),  
    ));

    getIt.registerSingleton<UserSignupRepository>(UserSignupImpl(
      getIt<SharedPreferenceHelper>(),
      getIt<ApiRegister>(),
    ));

     getIt.registerSingleton<ExpRepository>(ExpRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
      getIt<ApiCreateExp>(),
      getIt<ApiGetExp>(),
      
      
    ));

      getIt.registerSingleton<CategoryRepository>(CategoryRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
      getIt<ApiGetCategory>(),
      
    ));

      getIt.registerSingleton<StatisticRepository>(StatisticRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
      getIt<ApiStatistics>(),
      
    ));


    
  
  }
}
