import 'dart:async';
import 'package:flutter_application_1/domain/entities/User.dart';
import 'package:flutter_application_1/domain/usecases/user/signup_usecase.dart';


abstract class UserSignupRepository {
  Future<User?> register(RegisterParams params);
}
