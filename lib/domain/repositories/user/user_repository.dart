import 'dart:async';
import 'package:flutter_application_1/domain/entities/user/User.dart';
import 'package:flutter_application_1/domain/usecases/user/login_usecase.dart';

abstract class UserRepository {
  Future<User?> login(LoginParams params);

  Future<void> saveIsLoggedIn(bool value);

  Future<bool> get isLoggedIn;
  
}
