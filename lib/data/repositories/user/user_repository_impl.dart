import 'dart:async';
import 'package:flutter_application_1/data/network/api/api_login.dart';
import 'package:flutter_application_1/data/network/exceptions/network_exceptions.dart';
import 'package:flutter_application_1/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_application_1/domain/entities/user/User.dart';
import 'package:flutter_application_1/domain/repositories/user/user_repository.dart';
import 'package:flutter_application_1/domain/usecases/user/login_usecase.dart';

class UserRepositoryImpl extends UserRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;
  final ApiLogin _apiLogin;

  // constructor
  UserRepositoryImpl(this._sharedPrefsHelper, this._apiLogin);

  // Login:---------------------------------------------------------------------
  @override
  Future<User?> login(LoginParams params) async {
    try {
      final responseData = await _apiLogin.login(params.email, params.password);
      if (responseData.containsKey('token')) {
        await _sharedPrefsHelper.saveAuthToken(responseData['token']);
      }

      final user = User(
        userId: responseData['userId'] ?? '',
        email: responseData['email'],
        firstName: responseData['firstName'],
        lastName: responseData['lastName'],
        phoneNumber: responseData['phoneNumber'],
        password: params.password,
        dateOfBirth:
            responseData['dateOfBirth'] != null
                ? DateTime.parse(responseData['dateOfBirth'])
                : null, 
      );

      // Lưu trạng thái đăng nhập
      await saveIsLoggedIn(true);

      return user;
   } on NetworkException catch (e) {
    rethrow;
  } catch (e) {
     print('Unexpected error: $e');
    throw NetworkException(
      message: 'Đã xảy ra lỗi không xác định khi đăng nhập.',
    );
  }
  }

  @override
  Future<void> saveIsLoggedIn(bool value) async =>
      await _sharedPrefsHelper.saveIsLoggedIn(value);

  @override
  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;
}
