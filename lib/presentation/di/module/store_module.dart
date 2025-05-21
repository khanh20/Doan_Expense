import 'dart:async';
import 'package:flutter_application_1/core/store/error/error_store.dart';
import 'package:flutter_application_1/core/store/form/form_store.dart';
import 'package:flutter_application_1/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_application_1/domain/usecases/category/get_category_usecase.dart';
import 'package:flutter_application_1/domain/usecases/expense/create_exp_usecase.dart';
import 'package:flutter_application_1/domain/usecases/expense/statistic_usecase.dart';
import 'package:flutter_application_1/domain/usecases/user/is_logged_in_usecase.dart';
import 'package:flutter_application_1/domain/usecases/user/login_usecase.dart';
import 'package:flutter_application_1/domain/usecases/user/save_login_in_status_usecase.dart';
import 'package:flutter_application_1/domain/usecases/user/signup_usecase.dart';
import 'package:flutter_application_1/presentation/store/category_store.dart';
import 'package:flutter_application_1/presentation/store/home_store.dart';
import 'package:flutter_application_1/presentation/store/login_store.dart';
import 'package:flutter_application_1/presentation/store/signup_store.dart';
import 'package:flutter_application_1/presentation/store/statistic_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/service_locator.dart';

class StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    if (!getIt.isRegistered<SharedPreferenceHelper>()) {
      final prefs = await SharedPreferences.getInstance();
      getIt.registerSingleton<SharedPreferenceHelper>(
        SharedPreferenceHelper(prefs),
      );
    }

    getIt.registerFactory(() => ErrorStore());
    getIt.registerSingleton<FormErrorStore>(FormErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    getIt.registerFactory(
      () => SignupStore(
        getIt<RegisterUseCase>(),
        getIt<ErrorStore>(),
        getIt<FormErrorStore>(),
      ),
    );
    // stores:------------------------------------------------------------------
    getIt.registerSingleton<UserStore>(
      UserStore(
        getIt<IsLoggedInUseCase>(),
        getIt<SaveLoginStatusUseCase>(),
        getIt<LoginUseCase>(),
        getIt<FormErrorStore>(),
        getIt<ErrorStore>(),
      ),
    );
    getIt.registerSingleton<HomeStore>(
      HomeStore(getIt<CreateExpUsecase>(), getIt<ErrorStore>()),
    );
    getIt.registerSingleton<CategoryStore>(
      CategoryStore(getIt<GetCategoryUsecase>(), getIt<ErrorStore>()),
    );
    getIt.registerSingleton<StatisticStore>(
      StatisticStore(getIt<StatisticUsecase>(), getIt<ErrorStore>(),
          getIt<FormErrorStore>()),
    );
  }
}
