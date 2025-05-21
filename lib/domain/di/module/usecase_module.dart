import 'dart:async';
import 'package:flutter_application_1/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_application_1/domain/repositories/category_repository.dart';
import 'package:flutter_application_1/domain/repositories/exp_repository.dart';
import 'package:flutter_application_1/domain/repositories/statistic_repository.dart';
import 'package:flutter_application_1/domain/repositories/user/user_repository.dart';
import 'package:flutter_application_1/domain/repositories/user/user_signup.dart';
import 'package:flutter_application_1/domain/usecases/category/get_category_usecase.dart';
import 'package:flutter_application_1/domain/usecases/expense/create_exp_usecase.dart';
import 'package:flutter_application_1/domain/usecases/expense/statistic_usecase.dart';
import 'package:flutter_application_1/domain/usecases/user/is_logged_in_usecase.dart';
import 'package:flutter_application_1/domain/usecases/user/login_usecase.dart';
import 'package:flutter_application_1/domain/usecases/user/save_login_in_status_usecase.dart';
import 'package:flutter_application_1/domain/usecases/user/signup_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/service_locator.dart';

class UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    // user:--------------------------------------------------------------------
    if (!getIt.isRegistered<SharedPreferenceHelper>()) {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferenceHelper>(
    SharedPreferenceHelper(prefs),
  );
}

    getIt.registerSingleton<IsLoggedInUseCase>(
      IsLoggedInUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<SaveLoginStatusUseCase>(
      SaveLoginStatusUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<LoginUseCase>(
      LoginUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<RegisterUseCase>(
      RegisterUseCase(getIt<UserSignupRepository>()),
    );
    getIt.registerSingleton<CreateExpUsecase>(
      CreateExpUsecase(getIt<ExpRepository>()),
    );
    getIt.registerSingleton<GetCategoryUsecase>(
      GetCategoryUsecase(getIt<CategoryRepository>()),
    );
     getIt.registerSingleton<StatisticUsecase>(
      StatisticUsecase(getIt<StatisticRepository>()),
    );

    // // post:--------------------------------------------------------------------
    // getIt.registerSingleton<GetPostUseCase>(
    //   GetPostUseCase(getIt<PostRepository>()),
    // );
    // getIt.registerSingleton<FindPostByIdUseCase>(
    //   FindPostByIdUseCase(getIt<PostRepository>()),
    // );
    // getIt.registerSingleton<InsertPostUseCase>(
    //   InsertPostUseCase(getIt<PostRepository>()),
    // );
    // getIt.registerSingleton<UpdatePostUseCase>(
    //   UpdatePostUseCase(getIt<PostRepository>()),
    // );
    // getIt.registerSingleton<DeletePostUseCase>(
    //   DeletePostUseCase(getIt<PostRepository>()),
    // );
  }
}
