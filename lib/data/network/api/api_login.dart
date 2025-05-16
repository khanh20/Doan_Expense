import 'dart:async';
import 'package:flutter_application_1/data/network/constants/api_constant.dart';
import 'package:flutter_application_1/data/network/rest_client.dart';
import 'package:flutter_application_1/di/service_locator.dart';

class ApiLogin {
  final RestClient _restClient = getIt<RestClient>();

  ApiLogin();

  Future<Map<String, dynamic>> login(String email, String password) async {
      final response = await _restClient.post(
        "${APIConstants.api}user/Login",
        data: {"email": email, "password": password},
      );
      return response;
  
  }
}
