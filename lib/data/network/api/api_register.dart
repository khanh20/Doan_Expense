import 'dart:async';
import 'package:flutter_application_1/data/network/constants/api_constant.dart';
import 'package:flutter_application_1/data/network/rest_client.dart';
import 'package:flutter_application_1/di/service_locator.dart';

class ApiRegister {
  final RestClient _restClient = getIt<RestClient>();

  ApiRegister( );


  Future<Map<String, dynamic>> register(String email, String password,String firstName,String lastName,String phoneNumber,DateTime dateOfBirth) async {
      final response = await _restClient.post(
        "${APIConstants.api}user/signup",
        data: {
          "email": email,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
          "phoneNumber": phoneNumber,
          "dateOfBirth": dateOfBirth.toIso8601String(),
        },
      );
      print("Response data: $response");
      return response;
  }
}
