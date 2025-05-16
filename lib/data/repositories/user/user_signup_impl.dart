import 'dart:async';
import 'package:flutter_application_1/data/network/api/api_register.dart';
import 'package:flutter_application_1/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_application_1/domain/entities/user/User.dart';
import 'package:flutter_application_1/domain/repositories/user/user_signup.dart';
import 'package:flutter_application_1/domain/usecases/user/signup_usecase.dart';

class UserSignupImpl extends UserSignupRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;
  final ApiRegister _apiRegister;

  // constructor
  UserSignupImpl(this._sharedPrefsHelper, this._apiRegister);
  // Register:------------------------------------------------------------------
  @override
  Future<User?> register(RegisterParams params) async {
    try {
      final responseData = await _apiRegister.register(
        params.email, 
        params.password, 
        params.firstName, 
        params.lastName,
        params.phoneNumber,
        params.dateOfBirth,
      );

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
      print("User data: $user");
      return user;
      } catch (e) {
      print("Registration error: $e");
      return null;
    }
    }
    

      

  }



