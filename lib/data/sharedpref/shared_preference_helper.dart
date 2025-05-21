import 'dart:async';

import 'package:flutter_application_1/domain/entities/User.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;
  

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.auth_token);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.auth_token, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.auth_token);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }
  // User Information Methods: -------------------------------------------------

  // Get user information
  Future<String?> get userId async {
    return _sharedPreference.getString(Preferences.user_id);
  }

  Future<String?> get userEmail async {
    return _sharedPreference.getString(Preferences.user_email);
  }

  Future<String?> get firstName async {
    return _sharedPreference.getString(Preferences.first_name);
  }

  Future<String?> get lastName async {
    return _sharedPreference.getString(Preferences.last_name);
  }

  Future<String?> get phoneNumber async {
    return _sharedPreference.getString(Preferences.phone_number);
  }

  Future<String?> get dateOfBirth async {
    return _sharedPreference.getString(Preferences.date_of_birth);
  }

  // Save user information
  Future<bool> saveUserId(String userId) async {
    return _sharedPreference.setString(Preferences.user_id, userId);
  }

  Future<bool> saveUserEmail(String email) async {
    return _sharedPreference.setString(Preferences.user_email, email);
  }

  Future<bool> saveFirstName(String firstName) async {
    return _sharedPreference.setString(Preferences.first_name, firstName);
  }

  Future<bool> saveLastName(String lastName) async {
    return _sharedPreference.setString(Preferences.last_name, lastName);
  }

  Future<bool> savePhoneNumber(String phoneNumber) async {
    return _sharedPreference.setString(Preferences.phone_number, phoneNumber);
  }

  Future<bool> saveDateOfBirth(String dateOfBirth) async {
    return _sharedPreference.setString(Preferences.date_of_birth, dateOfBirth);
  }

  // Remove user information
  Future<bool> removeUserInfo() async {
    await _sharedPreference.remove(Preferences.user_id);
    await _sharedPreference.remove(Preferences.user_email);
    await _sharedPreference.remove(Preferences.first_name);
    await _sharedPreference.remove(Preferences.last_name);
    await _sharedPreference.remove(Preferences.phone_number);
    await _sharedPreference.remove(Preferences.date_of_birth);
    return true;
  }
    Future<void> saveUser(User user) async {
    await saveUserId(user.userId.toString());
    await saveUserEmail(user.email);
    await saveFirstName(user.firstName?? 'Chưa có Họ');
    await saveLastName(user.lastName?? 'Chưa có Tên');
    await savePhoneNumber(user.phoneNumber?? 'Chưa có SDT');
    if (user.dateOfBirth != null) {
      await saveDateOfBirth(user.dateOfBirth!.toIso8601String());
    }
  }
  // Get userId from token
    Future<String?> get userIdFromToken async {
    final token = await authToken;
    if (token == null || token.isEmpty) return null;
    final decoded = JwtDecoder.decode(token);
    return decoded['sid']; 
  }
Future<User?> getUser() async {
  final id = await userId;
  final email = await userEmail;
  final first = await firstName;
  final last = await lastName;
  final phone = await phoneNumber;
  final dobString = await dateOfBirth;

  // Nếu thiếu thông tin cơ bản thì trả về null
  if (id == null || email == null || first == null || last == null) {
    return null;
  }

  final dob = dobString != null ? DateTime.tryParse(dobString) : null;

  return User(
    userId: int.tryParse(id) ?? 0,
    email: email,
    firstName: first,
    lastName: last,
    phoneNumber: phone ?? '',
    dateOfBirth: dob,
    password: '', // Nếu không dùng đến, có thể bỏ qua hoặc dùng giá trị mặc định
  );
}


}


