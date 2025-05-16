import 'dart:async';

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

}